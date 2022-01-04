output "name" {
  description = "Function name which can be used to invoke it"
  value       = "requireBasicAuth"
}

output "code" {
  description = "Function code, including the signature"

  value = templatefile("${path.module}/basic_auth.js", {
    credentials = base64encode(var.credentials)
  })
}
