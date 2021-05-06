# zip

Creates a zip archive with the specified contents.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [archive_file.archive](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether any resources should be created | `bool` | `true` | no |
| <a name="input_directory"></a> [directory](#input\_directory) | Source code directory path. Either `files` or `directory` has to be specified | `string` | `null` | no |
| <a name="input_directory_exclude_patterns"></a> [directory\_exclude\_patterns](#input\_directory\_exclude\_patterns) | Source code file exclusion patterns in case some unnecessary files are matched by `directory_include_patterns`. | `list(string)` | `[]` | no |
| <a name="input_directory_include_patterns"></a> [directory\_include\_patterns](#input\_directory\_include\_patterns) | Source code file path patterns to narrow `directory` contents. | `list(string)` | <pre>[<br>  "**"<br>]</pre> | no |
| <a name="input_files"></a> [files](#input\_files) | Source code map. Either `files` or `directory` has to be specified | `map(string)` | `null` | no |
| <a name="input_output_path"></a> [output\_path](#input\_output\_path) | Path where the zip should be created, defaults to `{zip module path}/tmp/{hash}.zip`, any instances of `{hash}` will be replaced with the archive content hash. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_content_hash"></a> [content\_hash](#output\_content\_hash) | Hash of the content used in the default `output_path` |
| <a name="output_content_paths"></a> [content\_paths](#output\_content\_paths) | Paths that are included in the zip, eg. for debugging include/exclude patterns |
| <a name="output_output_base64sha256"></a> [output\_base64sha256](#output\_output\_base64sha256) | The base64-encoded SHA256 checksum of output archive file. |
| <a name="output_output_md5"></a> [output\_md5](#output\_output\_md5) | The MD5 checksum of output archive file. |
| <a name="output_output_path"></a> [output\_path](#output\_output\_path) | Path where the zip was created |
| <a name="output_output_sha"></a> [output\_sha](#output\_output\_sha) | The SHA1 checksum of output archive file. |
| <a name="output_output_size"></a> [output\_size](#output\_output\_size) | The size of the output archive file. |
<!-- END_TF_DOCS -->
