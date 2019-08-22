# ecs/services/worker

Creates an ECS service for background workers

## Inputs

| Name                     | Description                                                                                                                                                                                                                  |  Type  | Default | Required |
| ------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-----: | :------: |
| cluster\_arn             | ARN of the ECS cluster to create the service in                                                                                                                                                                              | string |   n/a   |   yes    |
| deployment\_max\_percent | The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Rounded down to get the maximum number of running tasks.                | string | `"200"` |    no    |
| deployment\_min\_percent | The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. Rounded up to get the minimum number of running tasks. | string | `"50"`  |    no    |
| desired\_count           | The number of instances of the task definition to place and keep running.                                                                                                                                                    | string |  `"2"`  |    no    |
| launch\_type             | The launch type on which to run your service. Either EC2 or FARGATE.                                                                                                                                                         | string | `"EC2"` |    no    |
| name                     | ECS service name                                                                                                                                                                                                             | string |   n/a   |   yes    |
| task\_definition\_arn    | ECS task definition ARN to run as a service                                                                                                                                                                                  | string |   n/a   |   yes    |

## Outputs

| Name | Description |
| ---- | ----------- |
| id   | Service id  |

