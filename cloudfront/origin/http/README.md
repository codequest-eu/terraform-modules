# cloudfront/origin/http

HTTPS origin factory for the `cloudfront` module

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |

## Inputs

* `domain` (`string`, required)

    Domain where the origin is hosted

* `headers` (`map(string)`, default: `{}`)

    Additional headers to pass to the origin

* `path` (`string`, default: `""`)

    Path where the origin is hosted

* `port` (`number`, default: `443`)

    Port on which the origin listens for HTTP/HTTPS requests



## Outputs

* `domain`

    Domain where the origin is hosted

* `headers`

    Additional headers to pass to the origin

* `path`

    Path where the origin is hosted

* `port`

    Port on which the origin listens for HTTP/HTTPS requests
