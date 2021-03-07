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

    Source code file exclusion patterns in case some unnecessary files are matched by `file_paths`.

* `file_patterns` (`list(string)`, default: `["**"]`)

    Source code file path patterns to narrow `files_dir` contents.

* `files` (`map(string)`, default: `null`)

    Source code map. Either `files` or `files_dir` has to be specified

* `files_dir` (`string`, default: `null`)

    Source code directory path. Either `files` or `files_dir` has to be specified

* `name` (`string`, required)

    Lambda layer name

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
