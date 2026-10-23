variable "name" {
  description = "Resource name. Lowercase letters, digits and hyphens."
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]{1,255}$", var.name))
    error_message = "name must match ^[a-z0-9-]{1,255}$."
  }
}

variable "context" {
  description = "Deployment context used for naming, tagging and environment-dependent defaults."
  type = object({
    organization = string
    environment  = string
    application  = string
    component    = optional(string)
    owner        = string
    cost_center  = string
    extra_tags   = optional(map(string), {})
  })
  validation {
    condition     = contains(["dev", "staging", "prod", "test", "shared"], var.context.environment)
    error_message = "context.environment must be one of dev, staging, prod, test, shared."
  }
}

variable "create" {
  description = "Whether to create any resources. Set false to plan nothing."
  type        = bool
  default     = true
}

variable "container_insights" {
  description = "CloudWatch Container Insights mode for the cluster: enabled, enhanced or disabled."
  type        = string
  default     = "enhanced"
  validation {
    condition     = contains(["enabled", "enhanced", "disabled"], var.container_insights)
    error_message = "container_insights must be one of enabled, enhanced, disabled."
  }
}

variable "capacity_providers" {
  description = "Capacity providers associated with the cluster and used as its default strategy, keyed by provider name (for example FARGATE, FARGATE_SPOT)."
  type = map(object({
    weight = number
    base   = optional(number, 0)
  }))
  default = {
    FARGATE      = { weight = 1 }
    FARGATE_SPOT = { weight = 0 }
  }
}

variable "service_connect_namespace" {
  description = "Name of an HTTP Cloud Map namespace to create and set as the cluster's default Service Connect namespace. Null creates none."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags merged onto every taggable resource, applied last."
  type        = map(string)
  default     = {}
}
