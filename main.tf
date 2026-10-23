locals {
  tags = merge(var.context.extra_tags, var.tags)

  create_namespace = var.create && var.service_connect_namespace != null
}

resource "aws_service_discovery_http_namespace" "this" {
  count = local.create_namespace ? 1 : 0

  name        = var.service_connect_namespace
  description = "Service Connect namespace for ECS cluster ${var.name}"

  tags = local.tags
}

module "this" {
  source  = "terraform-aws-modules/ecs/aws//modules/cluster"
  version = "7.6.1"

  create = var.create
  name   = var.name

  setting = [
    { name = "containerInsights", value = var.container_insights },
  ]

  # Fargate capacity providers are AWS-managed; no capacity providers are created here.
  cluster_capacity_providers = keys(var.capacity_providers)
  default_capacity_provider_strategy = {
    for k, v in var.capacity_providers : k => {
      weight = v.weight
      base   = v.base
    }
  }

  service_connect_defaults = local.create_namespace ? {
    namespace = aws_service_discovery_http_namespace.this[0].arn
  } : null

  # No execute-command logging is configured, so an unused log group is not created.
  create_cloudwatch_log_group = false

  tags = local.tags
}
