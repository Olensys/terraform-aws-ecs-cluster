# terraform-aws-ecs-cluster

ECS cluster on Fargate with Container Insights and capacity provider strategy

## Opinions

- Container Insights is `enhanced` by default; set `container_insights` to `enabled` or `disabled` to change it.
- Capacity providers default to `FARGATE` (weight 1) and `FARGATE_SPOT` (weight 0), used as the cluster's default strategy.
- No EC2 capacity providers, security group, task execution role or execute-command log group are created.
- An HTTP Service Connect namespace is created only when `service_connect_namespace` is set, and becomes the cluster default.
- Tags are `context.extra_tags` merged with `tags`, with `tags` applied last.

## Usage

```hcl
module "this" {
  source = "git::https://github.com/Olensys/terraform-aws-ecs-cluster.git?ref=v1.0.0"

  name = "example"
  context = {
    organization = "olensys"
    environment  = "dev"
    application  = "example"
    owner        = "platform"
    cost_center  = "eng"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0, < 7.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0, < 7.0 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| <a name="module_this"></a> [this](#module\_this) | terraform-aws-modules/ecs/aws//modules/cluster | 7.6.1 |

## Resources

| Name | Type |
| ---- | ---- |
| [aws_service_discovery_http_namespace.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/service_discovery_http_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_context"></a> [context](#input\_context) | Deployment context used for naming, tagging and environment-dependent defaults. | <pre>object({<br/>    organization = string<br/>    environment  = string<br/>    application  = string<br/>    component    = optional(string)<br/>    owner        = string<br/>    cost_center  = string<br/>    extra_tags   = optional(map(string), {})<br/>  })</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Resource name. Lowercase letters, digits and hyphens. | `string` | n/a | yes |
| <a name="input_capacity_providers"></a> [capacity\_providers](#input\_capacity\_providers) | Capacity providers associated with the cluster and used as its default strategy, keyed by provider name (for example FARGATE, FARGATE\_SPOT). | <pre>map(object({<br/>    weight = number<br/>    base   = optional(number, 0)<br/>  }))</pre> | <pre>{<br/>  "FARGATE": {<br/>    "weight": 1<br/>  },<br/>  "FARGATE_SPOT": {<br/>    "weight": 0<br/>  }<br/>}</pre> | no |
| <a name="input_container_insights"></a> [container\_insights](#input\_container\_insights) | CloudWatch Container Insights mode for the cluster: enabled, enhanced or disabled. | `string` | `"enhanced"` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create any resources. Set false to plan nothing. | `bool` | `true` | no |
| <a name="input_service_connect_namespace"></a> [service\_connect\_namespace](#input\_service\_connect\_namespace) | Name of an HTTP Cloud Map namespace to create and set as the cluster's default Service Connect namespace. Null creates none. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags merged onto every taggable resource, applied last. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the ECS cluster. Null when create is false. |
| <a name="output_id"></a> [id](#output\_id) | ID (ARN) of the ECS cluster. Null when create is false. |
| <a name="output_name"></a> [name](#output\_name) | Name of the ECS cluster. Null when create is false. |
| <a name="output_service_connect_namespace_arn"></a> [service\_connect\_namespace\_arn](#output\_service\_connect\_namespace\_arn) | ARN of the Service Connect namespace created by this module. Null when none is created or create is false. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags applied to every taggable resource, with context.extra\_tags merged in. Null when create is false. |
<!-- END_TF_DOCS -->
