# ses/domain

Registers a domain with AWS SES and verifies it

- Adds a domain to SES
- Adds an MX record pointing to either SES or a specified server
- Sets up [DKIM](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail), [SPF](https://en.wikipedia.org/wiki/Sender_Policy_Framework) and [DMARC](https://en.wikipedia.org/wiki/DMARC)
- Adds an IAM policy for sending emails via SES

> **Important**
>
> This module **does not** set up any inbound email rules.
>
> Module assumes you add additional resources to setup receiving emails with SES or provide an address to some other SMTP server which handles incoming emails.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `dkim` (`bool`, default: `true`)

    Whether to add a DKIM record

* `dmarc` (`bool`, default: `true`)

    Wheteher to add a DMARC record

* `dmarc_percent` (`number`, default: `100`)

    Percent of suspicious messages that the DMARC policy applies to.

* `dmarc_policy` (`string`, default: `"quarantine"`)

    DMARC policy, one of: none, quarantine, reject

* `dmarc_report_emails` (`list(string)`, default: `[]`)

    E-mail addresses that SMTP servers should send DMARC reports to

* `dmarc_strict_dkim_alignment` (`bool`, default: `false`)

    Enables strict alignment mode for DKIM

* `dmarc_strict_spf_alignment` (`bool`, default: `false`)

    Enables strict alignment mode for SPF

* `dmarc_subdomain_policy` (`string`, default: `"quarantine"`)

    DMARC policy for subdomains, one of: none, quarantine, reject

* `hosted_zone_id` (`string`, required)

    Route53 hosted zone id that the domain belongs to

* `incomming_region` (`string`, default: `null`)

    Region where SES incomming email handling is set up, defaults to the current region, which **might not support it**

* `mail_server` (`string`, default: `null`)

    **DEPRECATED, use `mx_records = ['10 {mail_server}']` instead**.<br/>Email server ip/domain, if omitted SES will be used for incomming emails

* `mx_records` (`list(string)`, default: `null`)

    MX records that point to your email servers, if omitted SES will be used for incomming emails

* `name` (`string`, required)

    Domain name to register with SES

* `spf` (`bool`, default: `true`)

    Whether to add a TXT record with SPF. If you need additional TXT records, create your own aws_route53_record and add the `spf_record` output to it

* `spf_include` (`list(string)`, default: `[]`)

    Domains to include in the SPF record, amazonses.com doesn't need to be specified

* `spf_ip4` (`list(string)`, default: `[]`)

    IPv4 addresses to include in the SPF record

* `spf_ip6` (`list(string)`, default: `[]`)

    IPv6 addresses to include in the SPF record



## Outputs

* `configuration_set`

    Configuration set to use to track metrics for this domain

* `email_headers`

    Headers that should be included in each email

* `metrics`

    Cloudwatch metrics, see [metrics.tf](./metrics.tf) for details

* `sender_policy_arn`

    IAM policy ARN for email senders

* `sender_policy_name`

    IAM policy name for email senders

* `smtp_host`

    SMTP host to use for sending emails

* `spf_record`

    SPF record which you should include in the domain's TXT record in case you specified `spf = false`

* `widgets`

    Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) for details
