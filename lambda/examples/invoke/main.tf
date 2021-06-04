provider "aws" {
  region = "eu-west-1"

  # https://github.com/hashicorp/terraform-provider-aws/issues/15952
  version = "3.12.0"
}

module "lambda_invoke" {
  source = "./../.."

  name = "terraform-modules-lambda-example-invoke"

  files = {
    "index.js" = <<EOF
      async function handler({ action, subject }) {
        console.log(`$${action} $${subject}`)
        return { action, subject }
      }

      module.exports = { handler }
    EOF
  }
}

resource "random_pet" "subject" {}

resource "null_resource" "invoke" {
  triggers = {
    subject = random_pet.subject.id
  }

  provisioner "local-exec" {
    when    = create
    command = "${path.module}/bin/invoke"
    environment = { EVENT = jsonencode({
      action  = "create"
      subject = self.triggers.subject
    }) }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/bin/invoke"
    environment = { EVENT = jsonencode({
      action  = "destroy"
      subject = self.triggers.subject
    }) }
  }
}
