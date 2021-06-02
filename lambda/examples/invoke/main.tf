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
      async function handler({ provisioner }) {
        console.log("Hello " + provisioner + "!")
        return provisioner
      }

      module.exports = { handler }
    EOF
  }
}

resource "null_resource" "invoke" {
  triggers = {
    version = module.lambda_invoke.version
  }

  provisioner "local-exec" {
    when        = create
    environment = { EVENT = jsonencode({ provisioner = "create" }) }
    command     = module.lambda_invoke.invoke_script
  }

  provisioner "local-exec" {
    when        = destroy
    environment = { EVENT = jsonencode({ provisioner = "destroy" }) }
    command     = module.lambda_invoke.invoke_script
  }
}
