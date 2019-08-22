output "id" {
  description = "Service id"
  value       = "${aws_ecs_service.service.id}"
}
