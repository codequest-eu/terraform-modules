data "aws_region" "current" {
  count = var.create ? 1 : 0
}

locals {
  region = var.create ? data.aws_region.current[0].name : ""
}

resource "aws_ses_domain_identity" "domain" {
  count = var.create ? 1 : 0

  domain = var.name
}

locals {
  domain        = var.create ? aws_ses_domain_identity.domain[0].domain : var.name
  ses_smtp_host = "email-smtp.${local.region}.amazonaws.com"
}

resource "aws_route53_record" "ses_verification" {
  count = var.create ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = "_amazonses.${local.domain}."
  type    = "TXT"
  ttl     = 60
  records = [aws_ses_domain_identity.domain[0].verification_token]
}

resource "aws_ses_domain_identity_verification" "domain" {
  count      = var.create ? 1 : 0
  depends_on = [aws_route53_record.ses_verification]

  domain = local.domain
}

# MX --------------------------------------------------------------------------

locals {
  ses_incomming_region = var.incomming_region != null ? var.incomming_region : local.region
  ses_incomming_server = "inbound-smtp.${local.ses_incomming_region}.amazonaws.com."

  mx_records = (
    var.mx_records != null ? var.mx_records :
    var.mail_server != null ? ["10 ${var.mail_server}"] :
    ["10 ${local.ses_incomming_server}"]
  )
}

resource "aws_route53_record" "mx" {
  count = var.create ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = "${local.domain}."
  type    = "MX"
  ttl     = 300
  records = local.mx_records
}

# SPF -------------------------------------------------------------------------

locals {
  spf_entries = concat(
    ["mx", "include:amazonses.com"],
    [for domain in var.spf_include : "include:${domain}"],
    [for ip in var.spf_ip4 : "ip4:${ip}"],
    [for ip in var.spf_ip6 : "ip6:${ip}"],
  )
  spf_record = "v=spf1 ${join(" ", local.spf_entries)} -all"
}

resource "aws_route53_record" "txt" {
  count = var.create && var.spf ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = "${local.domain}."
  type    = "TXT"
  ttl     = 300
  records = [local.spf_record]
}

# DKIM ------------------------------------------------------------------------

resource "aws_ses_domain_dkim" "domain" {
  count = var.create && var.dkim ? 1 : 0

  domain = local.domain
}


resource "aws_route53_record" "dkim_verification" {
  count = var.create && var.dkim ? 3 : 0

  zone_id = var.hosted_zone_id
  name    = "${aws_ses_domain_dkim.domain[0].dkim_tokens[count.index]}._domainkey.${local.domain}."
  type    = "CNAME"
  ttl     = 60
  records = ["${aws_ses_domain_dkim.domain[0].dkim_tokens[count.index]}.dkim.amazonses.com"]
}

# DMARC -----------------------------------------------------------------------

locals {
  dmarc_options = {
    v     = "DMARC1"
    p     = var.dmarc_policy
    sp    = var.dmarc_subdomain_policy
    pct   = var.dmarc_percent
    rua   = join(",", [for email in var.dmarc_report_emails : "mailto:${email}"])
    adkim = var.dmarc_strict_dkim_alignment ? "s" : "r"
    aspf  = var.dmarc_strict_spf_alignment ? "s" : "r"
  }
}

resource "aws_route53_record" "dmarc" {
  count = var.create && var.dmarc ? 1 : 0

  zone_id = var.hosted_zone_id
  name    = "_dmarc.${local.domain}."
  type    = "TXT"
  ttl     = 300
  records = [join(";", [for k, v in local.dmarc_options : "${k}=${v}"])]
}

# sender policy ---------------------------------------------------------------

data "aws_iam_policy_document" "sender" {
  count = var.create ? 1 : 0

  statement {
    actions = [
      "ses:SendEmail",
      "ses:SendTemplatedEmail",
      "ses:SendRawEmail",
      "ses:SendBulkTemplatedEmail"
    ]
    resources = ["*"]
    condition {
      test     = "StringLike"
      variable = "ses:FromAddress"
      values   = ["*@${local.domain}", "*@*.${local.domain}"]
    }
  }
}

resource "aws_iam_policy" "sender" {
  count      = var.create ? 1 : 0
  depends_on = [aws_ses_domain_identity_verification.domain]

  name        = "email-sender-${local.domain}"
  description = "Allows sending emails from @${local.domain}"
  policy      = data.aws_iam_policy_document.sender[0].json
}

# configuration set for cloudwatch metrics ------------------------------------

resource "aws_ses_configuration_set" "domain" {
  count = var.create ? 1 : 0

  name = replace(local.domain, ".", "-")
}

locals {
  configuration_set_name = var.create ? aws_ses_configuration_set.domain[0].name : ""
}

resource "aws_ses_event_destination" "metrics" {
  count = var.create ? 1 : 0

  configuration_set_name = local.configuration_set_name
  name                   = "metrics"
  enabled                = true

  # track all types
  matching_types = [
    "send",
    "reject",
    "bounce",
    "complaint",
    "delivery",
    "open",
    "click",
    "renderingFailure"
  ]

  cloudwatch_destination {
    value_source   = "messageTag"
    dimension_name = "ses:from-domain"
    default_value  = local.domain
  }
}
