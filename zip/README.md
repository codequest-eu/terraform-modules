# zip

Creates a zip archive with the specified contents.

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 0.12 |
| <a name="requirement_archive"></a> [archive](#requirement_archive)       | >= 2.0  |

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_archive"></a> [archive](#provider_archive) | >= 2.0  |

## Modules

No modules.

## Resources

| Name                                                                                                            | Type        |
| --------------------------------------------------------------------------------------------------------------- | ----------- |
| [archive_file.archive](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name                                                                                                            | Description                                                                                                                                                     | Type           | Default                    | Required |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | -------------------------- | :------: |
| <a name="input_create"></a> [create](#input_create)                                                             | Whether any resources should be created                                                                                                                         | `bool`         | `true`                     |    no    |
| <a name="input_directory"></a> [directory](#input_directory)                                                    | Source code directory path. Either `files` or `directory` has to be specified                                                                                   | `string`       | `null`                     |    no    |
| <a name="input_directory_exclude_patterns"></a> [directory_exclude_patterns](#input_directory_exclude_patterns) | Source code file exclusion patterns in case some unnecessary files are matched by `directory_include_patterns`.                                                 | `list(string)` | `[]`                       |    no    |
| <a name="input_directory_include_patterns"></a> [directory_include_patterns](#input_directory_include_patterns) | Source code file path patterns to narrow `directory` contents.                                                                                                  | `list(string)` | <pre>[<br> "**"<br>]</pre> |    no    |
| <a name="input_files"></a> [files](#input_files)                                                                | Source code map. Either `files` or `directory` has to be specified                                                                                              | `map(string)`  | `null`                     |    no    |
| <a name="input_output_path"></a> [output_path](#input_output_path)                                              | Path where the zip should be created, defaults to `{zip module path}/tmp/{hash}.zip`, any instances of `{hash}` will be replaced with the archive content hash. | `string`       | `null`                     |    no    |

## Outputs

| Name                                                                                         | Description                                                                    |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| <a name="output_content_hash"></a> [content_hash](#output_content_hash)                      | Hash of the content used in the default `output_path`                          |
| <a name="output_content_paths"></a> [content_paths](#output_content_paths)                   | Paths that are included in the zip, eg. for debugging include/exclude patterns |
| <a name="output_output_base64sha256"></a> [output_base64sha256](#output_output_base64sha256) | The base64-encoded SHA256 checksum of output archive file.                     |
| <a name="output_output_md5"></a> [output_md5](#output_output_md5)                            | The MD5 checksum of output archive file.                                       |
| <a name="output_output_path"></a> [output_path](#output_output_path)                         | Path where the zip was created                                                 |
| <a name="output_output_sha"></a> [output_sha](#output_output_sha)                            | The SHA1 checksum of output archive file.                                      |
| <a name="output_output_size"></a> [output_size](#output_output_size)                         | The size of the output archive file.                                           |
