locals {
  main_image      = contains(keys(var.images), "main") ? regex("^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))", var.images.main) : {}
  operator_image  = contains(keys(var.images), "operator") ? regex("^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))", var.images.operator) : {}
  preflight_image = contains(keys(var.images), "preflight") ? regex("^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))", var.images.preflight) : {}

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
}

resource "helm_release" "this" {
  name             = var.name
  repository       = var.repository
  chart            = var.chart
  namespace        = var.namespace
  create_namespace = var.create_namespace
  version          = var.release_version

  values = var.values

  dynamic "set" {
    iterator = each_item
    for_each = local.set_values

    content {
      name  = each_item.value.name
      value = each_item.value.value
      type  = try(each_item.value.type, null)
    }
  }

  dynamic "set_sensitive" {
    iterator = each_item
    for_each = var.set_sensitive_values

    content {
      name  = each_item.value.name
      value = each_item.value.value
      type  = try(each_item.value.type, null)
    }
  }
}
