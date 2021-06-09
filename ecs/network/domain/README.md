# ecs/network/domain

Creates a Route53 record that points to the cluster load balancer. If `https_listener_arn` is provided will also attach a certificate to the https listener.

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
| <a name="module_certificate"></a> [certificate](#module\_certificate) | ../../../ssl/acm | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lb_listener_certificate.api](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_certificate) | resource |
| [aws_route53_record.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ACM certificate ARN which should be used for this domain. If https\_listener\_arn is provided without a certificate\_arn, a certificate will be created for you. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_https"></a> [https](#input\_https) | Whether to add an SSL certificate to the load balancer's HTTPS listener | `bool` | `true` | no |
| <a name="input_https_listener_arn"></a> [https\_listener\_arn](#input\_https\_listener\_arn) | Load balancer HTTPS listener ARN | `string` | `null` | no |
| <a name="input_load_balancer_arn"></a> [load\_balancer\_arn](#input\_load\_balancer\_arn) | Load balancer ARN | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Domain which should CNAME to the load balancer | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to set on resources that support them | `map(string)` | `{}` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Route53 hosted zone id to add the CNAME record to | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_certificate_arn"></a> [certificate\_arn](#output\_certificate\_arn) | ACM certificate ARN that was added to the https listener |
<!-- END_TF_DOCS -->
