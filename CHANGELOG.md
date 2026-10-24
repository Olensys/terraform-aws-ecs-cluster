# Changelog

## [1.0.4](https://github.com/Olensys/terraform-aws-ecs-cluster/compare/v1.0.3...v1.0.4) (2026-10-24)


### Bug Fixes

* **examples:** unique application slug so concurrent integration runs do not collide ([#2](https://github.com/Olensys/terraform-aws-ecs-cluster/issues/2)) ([55951cb](https://github.com/Olensys/terraform-aws-ecs-cluster/commit/55951cb265d7a23781cd24ec00e8e720a494fda4))

## [1.0.3](https://github.com/Olensys/terraform-aws-ecs-cluster/compare/v1.0.2...v1.0.3) (2026-10-24)


### Bug Fixes

* **examples:** pin naming module to v1.0.1 ([e2675bb](https://github.com/Olensys/terraform-aws-ecs-cluster/commit/e2675bbaba087bc08a27075de767e48f2c126e7d))
* run integration on change and weekly instead of nightly ([dc160da](https://github.com/Olensys/terraform-aws-ecs-cluster/commit/dc160da954a39561a995c9c079ed145e10e7af74))

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
