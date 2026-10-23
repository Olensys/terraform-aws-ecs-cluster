mock_provider "aws" {
  mock_resource "aws_service_discovery_http_namespace" {
    defaults = {
      arn = "arn:aws:servicediscovery:eu-west-1:123456789012:namespace/ns-abcdefghijklmnop"
    }
  }
}

variables {
  context = {
    organization = "olensys"
    environment  = "test"
    application  = "example"
    owner        = "platform"
    cost_center  = "eng"
  }
  name = "example"
}

run "test_create_false_plans_nothing" {
  command = plan

  variables {
    create = false
  }

  assert {
    condition     = output.id == null && output.name == null && output.arn == null && output.service_connect_namespace_arn == null && output.tags == null
    error_message = "All outputs must be null when create is false."
  }
}

run "test_container_insights_default_enhanced" {
  command = plan

  # SMOKE: asserts only the variable default and the planned name; the applied Container Insights setting lives in the upstream child module and is proven by tests/complete.tftest.hcl.
  assert {
    condition     = var.container_insights == "enhanced"
    error_message = "container_insights must default to enhanced."
  }

  assert {
    condition     = output.name == "example" && length(output.tags) == 0
    error_message = "The cluster must be planned with the given name."
  }
}

run "test_fargate_providers_default" {
  command = plan

  # SMOKE: asserts only the variable defaults; the applied capacity provider strategy lives in the upstream child module and is proven by tests/complete.tftest.hcl.
  assert {
    condition     = toset(keys(var.capacity_providers)) == toset(["FARGATE", "FARGATE_SPOT"])
    error_message = "FARGATE and FARGATE_SPOT must be configured by default."
  }

  assert {
    condition     = var.capacity_providers["FARGATE"].weight == 1 && var.capacity_providers["FARGATE_SPOT"].weight == 0 && var.capacity_providers["FARGATE"].base == 0
    error_message = "Default strategy must weight FARGATE 1 and FARGATE_SPOT 0 with base 0."
  }
}

run "test_invalid_insights_rejected" {
  command = plan

  variables {
    container_insights = "full"
  }

  expect_failures = [var.container_insights]
}

run "test_name_length_validation" {
  command = plan

  variables {
    name = join("", [for i in range(256) : "a"])
  }

  expect_failures = [var.name]
}

run "test_service_connect_namespace_created" {
  command = plan

  variables {
    service_connect_namespace = "internal"
  }

  assert {
    condition     = aws_service_discovery_http_namespace.this[0].name == "internal"
    error_message = "The Service Connect namespace must be planned when requested."
  }
}

run "test_no_namespace_by_default" {
  command = plan

  assert {
    condition     = length(aws_service_discovery_http_namespace.this) == 0
    error_message = "No namespace may be planned unless requested."
  }
}

run "test_tags_contract" {
  command = plan

  variables {
    tags = { Owner = "x" }
    context = {
      organization = "olensys"
      environment  = "test"
      application  = "example"
      owner        = "platform"
      cost_center  = "eng"
      extra_tags   = { Owner = "y", Team = "z" }
    }
  }

  assert {
    condition     = output.tags.Owner == "x"
    error_message = "var.tags must win over context.extra_tags."
  }

  assert {
    condition     = output.tags.Team == "z"
    error_message = "context.extra_tags must be merged."
  }
}
