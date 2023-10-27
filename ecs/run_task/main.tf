data "aws_region" "current" {}

resource "null_resource" "run" {
  triggers = {
    region          = data.aws_region.current.name
    cluster         = var.cluster_arn
    task_definition = var.task_definition_arn
    task_overrides  = var.task_overrides
  }

  provisioner "local-exec" {
    environment = {
      AWS_REGION          = self.triggers.region
      CLUSTER_ARN         = self.triggers.cluster
      TASK_DEFINITION_ARN = self.triggers.task_definition
      TASK_OVERRIDES      = self.triggers.task_overrides
    }

    command = "${path.module}/bin/run-task"
  }
}
