# ecs/services/web

Creates an ECS service exposed to the internet using an Application Load Balancer.

## Inputs

| Name                     | Description                                                                                                                                                                                                                  |  Type  |     Default      | Required |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :--------------: | :------: |
| cluster\_arn             | ARN of the ECS cluster to create the service in                                                                                                                                                                              | string |       n/a        |   yes    |
| container                | Container to forward requests to, defaults to service name                                                                                                                                                                   | string |       `""`       |    no    |
| container\_port          | Port on which the container is listening                                                                                                                                                                                     | string |      `"80"`      |    no    |
| deployment\_max\_percent | The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Rounded down to get the maximum number of running tasks.                | string |     `"200"`      |    no    |
| deployment\_min\_percent | The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. Rounded up to get the minimum number of running tasks. | string |      `"50"`      |    no    |
| deregistration\_delay    | Connection draining time in seconds.                                                                                                                                                                                         | string |      `"30"`      |    no    |
| desired\_count           | The number of instances of the task definition to place and keep running.                                                                                                                                                    | string |      `"2"`       |    no    |
| healthcheck\_interval    | How often, in seconds, healtchecks should be sent.                                                                                                                                                                           | string |      `"5"`       |    no    |
| healthcheck\_path        | Healthcheck endpoint path                                                                                                                                                                                                    | string | `"/healthcheck"` |    no    |
| healthcheck\_status      | Healthy response status                                                                                                                                                                                                      | string |     `"200"`      |    no    |
| healthcheck\_timeout     | Healthcheck request timeout, in seconds.                                                                                                                                                                                     | string |      `"2"`       |    no    |
| healthy\_threshold       | The number of consecutive health checks successes required before considering an unhealthy target healthy                                                                                                                    | string |      `"2"`       |    no    |
| launch\_type             | The launch type on which to run your service. Either EC2 or FARGATE.                                                                                                                                                         | string |     `"EC2"`      |    no    |
| listener\_arn            | ALB listener ARN                                                                                                                                                                                                             | string |       n/a        |   yes    |
| name                     | ECS service name                                                                                                                                                                                                             | string |       n/a        |   yes    |
| role\_arn                | ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf.                                                                                                                               | string |       n/a        |   yes    |
| rule\_domain             |                                                                                                                                                                                                                              | string |      `"*"`       |    no    |
| rule\_path               |                                                                                                                                                                                                                              | string |      `"/*"`      |    no    |
| slow\_start              | The amount time to warm up before the load balancer sends the full share of requests.                                                                                                                                        | string |      `"0"`       |    no    |
| target\_group\_name      | Load balancer target group name, defaults to {cluster name}-{service name}. Max 32 characters.                                                                                                                               | string |       `""`       |    no    |
| task\_definition\_arn    | ECS task definition ARN to run as a service                                                                                                                                                                                  | string |       n/a        |   yes    |
| unhealthy\_threshold     | The number of consecutive health check failures required before considering the target unhealthy                                                                                                                             | string |      `"2"`       |    no    |
| vpc\_id                  | VPC id                                                                                                                                                                                                                       | string |       n/a        |   yes    |

## Outputs

| Name                | Description                     |
| ------------------- | ------------------------------- |
| id                  | Service id                      |
| target\_group\_arn  | Load balancer target group ARN  |
| target\_group\_name | Load balancer target group name |

