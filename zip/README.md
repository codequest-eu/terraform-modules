# zip

Creates a zip archive with the specified contents.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `archive` | `>= 2.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Whether any resources should be created

* `directory` (`string`, default: `null`)

    Source code directory path. Either `files` or `directory` has to be specified

* `directory_exclude_patterns` (`list(string)`, default: `[]`)

    Source code file exclusion patterns in case some unnecessary files are matched by `directory_include_patterns`.

* `directory_include_patterns` (`list(string)`, default: `["**"]`)

    Source code file path patterns to narrow `directory` contents.

* `files` (`map(string)`, default: `null`)

    Source code map. Either `files` or `directory` has to be specified

* `output_path` (`string`, default: `null`)

    Path where the zip should be created, defaults to `{zip module path}/tmp/{hash}.zip`, any instances of `{hash}` will be replaced with the archive content hash.



## Outputs

* `content_hash`

    Hash of the content used in the default `output_path`

* `content_paths`

    Paths that are included in the zip, eg. for debugging include/exclude patterns

* `output_base64sha256`

    The base64-encoded SHA256 checksum of output archive file.

* `output_md5`

    The MD5 checksum of output archive file.

* `output_path`

    Path where the zip was created

* `output_sha`

    The SHA1 checksum of output archive file.

* `output_size`

    The size of the output archive file.
