# lambda

Creates an AWS Lambda function

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `archive` | `>= 1.2.2` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `environment_variables` (`map(string)`, default: `{}`)

    Environment variables

* `file_exclude_patterns` (`list(string)`, default: `[]`)

    Source code file exclusion patterns in case some unnecessary files are matched by `file_paths`.

* `file_patterns` (`list(string)`, default: `["**"]`)

    Source code file path patterns to narrow `files_dir` contents.

* `files` (`map(string)`, default: `null`)

    Source code map. Either `files` or `files_dir` has to be specified

* `files_dir` (`string`, default: `null`)

    Source code directory path. Either `files` or `files_dir` has to be specified

* `handler` (`string`, default: `"index.handler"`)

    Path to the event handler

* `memory_size` (`number`, default: `128`)

    Amount of memory in MB your Lambda Function can use at runtime

* `name` (`string`, required)

    Lambda name

* `policy_arns` (`map(string)`, default: `{}`)

    Additional policy ARNs to attach to the Lambda role

* `runtime` (`string`, default: `"nodejs12.x"`)

    [Runtime](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime)

* `security_group_ids` (`list(string)`, default: `null`)

    Security groups to assign

* `subnet_ids` (`list(string)`, default: `null`)

    Subnet ids to place the lambda in

* `tags` (`map(string)`, default: `{}`)

    Tags to set on resources that support them

* `timeout` (`number`, default: `3`)

    The amount of time your Lambda Function has to run in seconds



## Outputs

* `arn`

    Lambda function ARN
