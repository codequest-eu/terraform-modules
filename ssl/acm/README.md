# AWS ACM Certificate

Creates an SSL certificate using AWS ACM, verifies domain ownership using Route53 and returns it's ARN, so it can be attached to AWS resources, eg. CloudFront.

> **Note**  
> Due to Terraform 0.11 limitations ([terraform #18359](https://github.com/hashicorp/terraform/issues/18359)) module only supports up to 4 domains for a given certificate, which should be plenty for most cases.

## Inputs

| Name             | Description                                                                                  |  Type  | Default | Required |
| ---------------- | -------------------------------------------------------------------------------------------- | :----: | :-----: | :------: |
| domains          | Certificate domains, have to be in one Route53 hosted zone. You can specify up to 4 domains. |  list  |   n/a   |   yes    |
| hosted\_zone\_id | Route53 hosted zone id for ACM domain ownership validation                                   | string |   n/a   |   yes    |
| tags             | Tags to set on resources that support them                                                   |  map   | `<map>` |    no    |

## Outputs

| Name | Description         |
| ---- | ------------------- |
| arn  | ACM certificate ARN |
| id   | ACM certificate id  |

