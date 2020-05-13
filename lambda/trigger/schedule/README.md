# lambda/trigger/schedule

Sets up lambda triggering on schedule using a Cloudwatch event rule.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `description` (`string`, default: `null`)

    Description for the Cloudwatch event rule

* `lambda_arn` (`string`, required)

    ARN of the Lambda function that should be triggered

* `name` (`string`, required)

    Name of the Cloudwatch event rule to create

* `schedule` (`string`, required)

    Schedule expression when the Lambda should be triggered,
    see [scheduled events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html)
    for details


* `tags` (`map(string)`, default: `{}`)

    Tags to set on resources that support them



## Outputs

* `rule_arn`

    Cloudwatch event rule ARN

* `rule_name`

    Cloudwatch event rule name
