locals {
  main_image      = contains(keys(var.images), "main") ? regex(var.repo_regex, var.images.main) : {}
  operator_image  = contains(keys(var.images), "operator") ? regex(var.repo_regex, var.images.operator) : {}
  preflight_image = contains(keys(var.images), "preflight") ? regex(var.repo_regex, var.images.preflight) : {}

  default_preflight_set_values = [
    {
      name  = "preflight.enabled"
      value = "true"
    },
    {
      name  = "agent"
      value = "false"
    },
    {
      name  = "operator.enabled"
      value = "false"
    },
  ]

  main_set_values      = local.main_image != {} ? [{ name = "image.repository", value = "${local.main_image.url}/${local.main_image.image}" }, { name = "image.useDigest", value = "false" }] : []
  operator_set_values  = local.operator_image != {} ? [{ name = "operator.image.repository", value = "${local.operator_image.url}/${local.operator_image.image}" }, { name = "operator.image.useDigest", value = "false" }] : []
  preflight_set_values = local.preflight_image != {} ? concat([{ name = "preflight.image.repository", value = "${local.preflight_image.url}/${local.preflight_image.image}" }, { name = "preflight.image.useDigest", value = "false" }], local.default_preflight_set_values) : []

  set_values = concat(var.set_values, local.main_set_values, local.operator_set_values, local.preflight_set_values)


  default_helm_config = {
    name             = var.name
    repository       = var.repository
    chart            = var.chart
    namespace        = var.namespace
    create_namespace = var.create_namespace
    version          = var.release_version
    values           = var.values
  }

  helm_config = merge(local.default_helm_config, var.helm_config)
}

module "helm" {
  source               = "github.com/terraform-helm/terraform-helm?ref=0.1"
  helm_config          = local.helm_config
  set_values           = local.set_values
  set_sensitive_values = var.set_sensitive_values
}
