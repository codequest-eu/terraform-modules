# rds/postgres/management_lambda

Creates an AWS Lambda function which can be used to manage the RDS instance:

- create/drop users
- create/drop databases

## Contributing

Since it would be unreasonable to require a working installation of node.js on every machine that wants to apply the module, a compiled version of lambda's code is put in the `./dist` directory and included in the repository.

Remember to always run `npm run build` before committing any changes in `src`, so `src` and `dist` are kept in sync.

> **To do**
>
> Figure out a better way to handle this or at least add a CI step to verify `dist` is up-to-date.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |
| `random` | `>= 2.1.2` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `database_url` (`string`, required)

    Database URL with master credentials

* `name` (`string`, required)

    Lambda name

* `subnet_ids` (`list(string)`, required)

    Ids of subnets to place the lambda in

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them

* `vpc_id` (`string`, required)

    Id of the VPC to place the lambda in



## Outputs

* `arn`

    The ARN identifying the Lambda Function

* `name`

    The Lambda Function name

* `qualified_arn`

    The ARN identifying the Lambda Function Version

* `security_group_id`

    Security group id
