# Changelog

## 1.0.1

### Fixes

- render declared provider constraints and skip .terraform in trivy scans
- declare required_version and providers in examples/minimal

## 1.0.0

- ECS cluster module wrapping terraform-aws-modules/ecs/aws//modules/cluster 7.6.1.
- Container Insights defaults to enhanced; FARGATE and FARGATE_SPOT capacity providers by default.
- Optional HTTP Service Connect namespace set as the cluster default.
