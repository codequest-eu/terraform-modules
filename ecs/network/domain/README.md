# ecs/network/domain

Creates a Route53 record that points to the cluster load balancer. If `https_listener_arn` is provided will also attach a certificate to the https listener.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.22.0` |

## Inputs

* `certificate_arn` (`string`, required)

    ACM certificate ARN which should be used for this domain. If https_listener_arn is provided without a certificate_arn, a certificate will be created for you.

* `create` (`bool`, default: `true`)

    Should resources be created

* `https_listener_arn` (`string`, required)

    Load balancer HTTPS listener ARN

* `load_balancer_arn` (`string`, required)

    Load balancer ARN

* `name` (`string`, required)

    Domain which should CNAME to the load balancer

* `tags` (`map(string)`, required)

    Tags to set on resources that support them

* `zone_id` (`string`, required)

    Route53 hosted zone id to add the CNAME record to



## Outputs

* `certificate_arn`

    ACM certificate ARN that was added to the https listener
