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

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_annotation_max_bounce_rate"></a> [annotation\_max\_bounce\_rate](#module\_annotation\_max\_bounce\_rate) | ./../../cloudwatch/annotation | n/a |
| <a name="module_annotation_max_spam_rate"></a> [annotation\_max\_spam\_rate](#module\_annotation\_max\_spam\_rate) | ./../../cloudwatch/annotation | n/a |
| <a name="module_annotation_warning_bounce_rate"></a> [annotation\_warning\_bounce\_rate](#module\_annotation\_warning\_bounce\_rate) | ./../../cloudwatch/annotation | n/a |
| <a name="module_annotation_warning_spam_rate"></a> [annotation\_warning\_spam\_rate](#module\_annotation\_warning\_spam\_rate) | ./../../cloudwatch/annotation | n/a |
| <a name="module_cloudwatch_consts"></a> [cloudwatch\_consts](#module\_cloudwatch\_consts) | ./../../cloudwatch/consts | n/a |
| <a name="module_metrics_account_reputation"></a> [metrics\_account\_reputation](#module\_metrics\_account\_reputation) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_count"></a> [metrics\_count](#module\_metrics\_count) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_percentage"></a> [metrics\_percentage](#module\_metrics\_percentage) | ./../../cloudwatch/metric_expression/many | n/a |
| <a name="module_widget_account_bounce_rate"></a> [widget\_account\_bounce\_rate](#module\_widget\_account\_bounce\_rate) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_account_spam_rate"></a> [widget\_account\_spam\_rate](#module\_widget\_account\_spam\_rate) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_conversion"></a> [widget\_conversion](#module\_widget\_conversion) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_delivery"></a> [widget\_delivery](#module\_widget\_delivery) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_delivery_percentage"></a> [widget\_delivery\_percentage](#module\_widget\_delivery\_percentage) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_spam"></a> [widget\_spam](#module\_widget\_spam) | ./../../cloudwatch/metric_widget | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.sender](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_route53_record.dkim_verification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.dmarc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.mx](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.ses_verification](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.txt](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_ses_configuration_set.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_configuration_set) | resource |
| [aws_ses_domain_dkim.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_identity_verification.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity_verification) | resource |
| [aws_ses_event_destination.metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_event_destination) | resource |
| [aws_iam_policy_document.sender](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_dkim"></a> [dkim](#input\_dkim) | Whether to add a DKIM record | `bool` | `true` | no |
| <a name="input_dmarc"></a> [dmarc](#input\_dmarc) | Wheteher to add a DMARC record | `bool` | `true` | no |
| <a name="input_dmarc_percent"></a> [dmarc\_percent](#input\_dmarc\_percent) | Percent of suspicious messages that the DMARC policy applies to. | `number` | `100` | no |
| <a name="input_dmarc_policy"></a> [dmarc\_policy](#input\_dmarc\_policy) | DMARC policy, one of: none, quarantine, reject | `string` | `"quarantine"` | no |
| <a name="input_dmarc_report_emails"></a> [dmarc\_report\_emails](#input\_dmarc\_report\_emails) | E-mail addresses that SMTP servers should send DMARC reports to | `list(string)` | `[]` | no |
| <a name="input_dmarc_strict_dkim_alignment"></a> [dmarc\_strict\_dkim\_alignment](#input\_dmarc\_strict\_dkim\_alignment) | Enables strict alignment mode for DKIM | `bool` | `false` | no |
| <a name="input_dmarc_strict_spf_alignment"></a> [dmarc\_strict\_spf\_alignment](#input\_dmarc\_strict\_spf\_alignment) | Enables strict alignment mode for SPF | `bool` | `false` | no |
| <a name="input_dmarc_subdomain_policy"></a> [dmarc\_subdomain\_policy](#input\_dmarc\_subdomain\_policy) | DMARC policy for subdomains, one of: none, quarantine, reject | `string` | `"quarantine"` | no |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | Route53 hosted zone id that the domain belongs to | `string` | n/a | yes |
| <a name="input_incomming_region"></a> [incomming\_region](#input\_incomming\_region) | Region where SES incomming email handling is set up, defaults to the current region, which **might not support it** | `string` | `null` | no |
| <a name="input_mail_server"></a> [mail\_server](#input\_mail\_server) | **DEPRECATED, use `mx_records = ['10 {mail_server}']` instead**.<br/>Email server ip/domain, if omitted SES will be used for incomming emails | `string` | `null` | no |
| <a name="input_mx_records"></a> [mx\_records](#input\_mx\_records) | MX records that point to your email servers, if omitted SES will be used for incomming emails | `list(string)` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Domain name to register with SES | `string` | n/a | yes |
| <a name="input_spf"></a> [spf](#input\_spf) | Whether to add a TXT record with SPF. If you need additional TXT records, create your own aws\_route53\_record and add the `spf_record` output to it | `bool` | `true` | no |
| <a name="input_spf_include"></a> [spf\_include](#input\_spf\_include) | Domains to include in the SPF record, amazonses.com doesn't need to be specified | `list(string)` | `[]` | no |
| <a name="input_spf_ip4"></a> [spf\_ip4](#input\_spf\_ip4) | IPv4 addresses to include in the SPF record | `list(string)` | `[]` | no |
| <a name="input_spf_ip6"></a> [spf\_ip6](#input\_spf\_ip6) | IPv6 addresses to include in the SPF record | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_configuration_set"></a> [configuration\_set](#output\_configuration\_set) | Configuration set to use to track metrics for this domain |
| <a name="output_email_headers"></a> [email\_headers](#output\_email\_headers) | Headers that should be included in each email |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch metrics, see [metrics.tf](./metrics.tf) for details |
| <a name="output_sender_policy_arn"></a> [sender\_policy\_arn](#output\_sender\_policy\_arn) | IAM policy ARN for email senders |
| <a name="output_sender_policy_name"></a> [sender\_policy\_name](#output\_sender\_policy\_name) | IAM policy name for email senders |
| <a name="output_smtp_host"></a> [smtp\_host](#output\_smtp\_host) | SMTP host to use for sending emails |
| <a name="output_spf_record"></a> [spf\_record](#output\_spf\_record) | SPF record which you should include in the domain's TXT record in case you specified `spf = false` |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) for details |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->
