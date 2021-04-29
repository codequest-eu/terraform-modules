resource "null_resource" "invalidate" {
  count = var.create ? 1 : 0

  triggers = var.triggers

  provisioner "local-exec" {
    command = <<-EOT
      set -e

      export AWS_REGION=us-east-1

      cat <<'EOF'
      Invalidating ${var.distribution_id} paths:
      ${join("\n", var.paths)}
      EOF

      invalidation_id=$(
        aws cloudfront create-invalidation \
          --distribution-id '${var.distribution_id}' \
          --paths ${join(" ", [for path in var.paths : "'${path}'"])} \
          --query 'Invalidation.Id' \
          --output text
      )

      invalidation_status=InProgress

      while [ "$invalidation_status" != "Completed" ]; do
        echo "Waiting for invalidation $invalidation_id to complete..."
        sleep 10
        invalidation_status=$(
          aws cloudfront get-invalidation \
            --distribution-id '${var.distribution_id}' \
            --id "$invalidation_id" \
            --query 'Invalidation.Status' \
            --output text
        )
      done
    EOT
  }
}
