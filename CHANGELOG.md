# Changelog

## 1.0.2

### Tests

- Added `test_tags_contract`: `tags` wins over `context.extra_tags`, and extra tags are merged.
- `test_container_insights_default_enhanced` and `test_fargate_providers_default` are marked `# SMOKE:` because they only assert variable defaults; the applied behaviour is proven by the nightly apply.

### Docs

- README Usage shows the naming module.

## 1.0.1

### Fixes

- render declared provider constraints and skip .terraform in trivy scans
- declare required_version and providers in examples/minimal

## 1.0.0

- ECS cluster module wrapping terraform-aws-modules/ecs/aws//modules/cluster 7.6.1.
- Container Insights defaults to enhanced; FARGATE and FARGATE_SPOT capacity providers by default.
- Optional HTTP Service Connect namespace set as the cluster default.
