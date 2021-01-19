# lambda/layer

Creates an AWS Lambda Layer that can be attached to a AWS Lambda Function

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

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


* `name` (`string`, required)

    Lambda layer name

* `package_path` (`string`, default: `null`)

    Path to the zip that contains the Lambda layer's source. Either `package_path`, `package_s3` or `image` is required.

* `package_s3` (`string`, default: `null`)

    S3 object path to a zip that contains the Lambda layer's source in a `{bucket}/{key}` format. Either `package_path`, `package_s3` or `image` is required.

* `package_s3_version` (`string`, default: `null`)

    Version number of the S3 object to use

* `runtimes` (`list(string)`, default: `["nodejs12.x"]`)

    [Runtimes](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) compatible with this lambda layer



## Outputs

* `arn`

    The ARN identifying the Lambda Layer

* `name`

    The Lambda Layer name

* `qualified_arn`

    The ARN identifying the Lambda Layer Version

* `version`

    Latest published version of the Lambda Layer
