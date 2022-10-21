locals {
  main_image     = regex("^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))", var.images.main)
  operator_image = regex("^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))", var.images.operator)
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
    for_each = var.set_values

    content {
      name  = each_item.value.name
      value = each_item.value.value
      type  = try(each_item.value.type, null)
    }
  }

  set {
    name  = "image.repository"
    value = "${local.main_image.url}/${local.main_image.image}"
  }

  set {
    name  = "operator.image.repository"
    value = "${local.operator_image.url}/${local.operator_image.image}"
  }

  set {
    name  = "image.useDigest"
    value = "false"
  }
  set {
    name  = "operator.image.useDigest"
    value = "false"
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
