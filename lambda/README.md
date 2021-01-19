# lambda

Creates an AWS Lambda function

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 3.19.0` |

## Inputs

* `assume_role_principals` (`list(string)`, default: `[]`)

    Which additional AWS services can assume the lambda role and invoke it

* `create` (`bool`, default: `true`)

    Should resources be created

* `environment_variables` (`map(string)`, default: `{}`)

    Environment variables

* `file_exclude_patterns` (`list(string)`, default: `[]`)

    **Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code file exclusion patterns in case some unnecessary files are matched by `file_paths`.


* `file_patterns` (`list(string)`, default: `["**"]`)

    **Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code file path patterns to narrow `files_dir` contents.


* `files` (`map(string)`, default: `null`)

    **Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code map. Either `files` or `files_dir` has to be specified


* `files_dir` (`string`, default: `null`)

    **Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code directory path. Either `files` or `files_dir` has to be specified


* `handler` (`string`, default: `"index.handler"`)

    Path to the event handler

* `image` (`string`, default: `null`)

    URI of a container image with the Lambda's source. Either `package_path`, `package_s3` or `image` is required.

* `layer_qualified_arns` (`list(string)`, default: `[]`)

    Lambda layers to include

* `memory_size` (`number`, default: `128`)

    Amount of memory in MB your Lambda Function can use at runtime

* `name` (`string`, required)

    Lambda name

* `package_path` (`string`, default: `null`)

    Path to the zip that contains the Lambda's source. Either `package_path`, `package_s3` or `image` is required.

* `package_s3` (`string`, default: `null`)

    S3 object path to a zip that contains the Lambda's source in a `{bucket}/{key}` format. Either `package_path`, `package_s3` or `image` is required.

* `package_s3_version` (`string`, default: `null`)

    Version number of the S3 object to use

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

    The ARN identifying the Lambda Function

* `invoke_arn`

    The ARN to be used for invoking Lambda Function from API Gateway

* `invoke_script`

    Shell script for invoking the lambda using AWS CLI.
    Expects the event JSON to be passed via `$EVENT` environment variable.
    Useful for invoking the lambda during `terraform apply` using `null_resource`.


* `metrics`

    Cloudwatch monitoring metrics

* `name`

    The Lambda Function name

* `qualified_arn`

    The ARN identifying the Lambda Function Version

* `version`

    Latest published version of the Lambda Function

* `widgets`

    Cloudwatch dashboard widgets
