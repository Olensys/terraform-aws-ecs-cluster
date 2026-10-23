output "id" {
  description = "ID (ARN) of the ECS cluster. Null when create is false."
  value       = var.create ? module.this.id : null
}

output "name" {
  description = "Name of the ECS cluster. Null when create is false."
  value       = var.create ? module.this.name : null
}

output "arn" {
  description = "ARN of the ECS cluster. Null when create is false."
  value       = var.create ? module.this.arn : null
}

output "service_connect_namespace_arn" {
  description = "ARN of the Service Connect namespace created by this module. Null when none is created or create is false."
  value       = try(aws_service_discovery_http_namespace.this[0].arn, null)
}

output "tags" {
  description = "Tags applied to every taggable resource, with context.extra_tags merged in. Null when create is false."
  value       = var.create ? local.tags : null
}
