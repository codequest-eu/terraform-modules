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

* `dmarc_report_emails` (`list(string)`, required)

    E-mail addresses that SMTP servers should send DMARC reports to

* `dmarc_strict_dkim_alignment` (`bool`, required)

    Enables strict alignment mode for DKIM

* `dmarc_strict_spf_alignment` (`bool`, required)

    Enables strict alignment mode for SPF

* `dmarc_subdomain_policy` (`string`, default: `"quarantine"`)

    DMARC policy for subdomains, one of: none, quarantine, reject

* `hosted_zone_id` (`string`, required)

    Route53 hosted zone id that the domain belongs to

* `incomming_region` (`string`, required)

    Region where SES incomming email handling is set up, defaults to the current region, which **might not support it**

* `mail_server` (`string`, required)

    **DEPRECATED, use `mx_records = ['10 {mail_server}']` instead**.<br/>Email server ip/domain, if omitted SES will be used for incomming emails

* `mx_records` (`list(string)`, required)

    MX records that point to your email servers, if omitted SES will be used for incomming emails

* `name` (`string`, required)

    Domain name to register with SES

* `spf` (`bool`, default: `true`)

    Whether to add an SPF record

* `spf_include` (`list(string)`, required)

    Domains to include in the SPF record, amazonses.com doesn't need to be specified

* `spf_ip4` (`list(string)`, required)

    IPv4 addresses to include in the SPF record

* `spf_ip6` (`list(string)`, required)

    IPv6 addresses to include in the SPF record

* `txt_records` (`list(string)`, required)

    TXT records to be included



## Outputs

* `sender_policy_arn`

    IAM policy ARN for email senders

* `sender_policy_name`

    IAM policy name for email senders
