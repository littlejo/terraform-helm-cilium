locals {
  default_ebpf_hostrouting_set_values = var.ebpf_hostrouting ? var.default_values.ebpf_hostrouting : []
  default_hubble_set_values           = var.hubble ? var.default_values.hubble : []
  default_hubble_ui_set_values        = var.hubble_ui ? concat(var.default_values.hubble_ui, var.default_values.hubble) : []
  default_gateway_api_set_values      = var.gateway_api ? var.default_values.gateway_api : []

  default_azure_set_values = var.azure_resource_group != null ? concat(var.default_values.azure, [{ name = "azure.resourceGroup", value = var.azure_resource_group }]) : []

  default_kubeproxy_replace_set_values = var.kubeproxy_replace_host != null ? concat(var.default_values.kubeproxy_replace, [{ name = "k8sServiceHost", value = split(":", var.kubeproxy_replace_host)[0] }, { name = "k8sServicePort", value = split(":", var.kubeproxy_replace_host)[1] }]) : []

  default_preflight_set_values = var.preflight ? var.default_values.preflight : []
  preflight_set_values         = concat(module.preflight_image.set_values, local.default_preflight_set_values)

  global_set_values = [
    var.set_values,
    module.main_image.set_values,
    module.operator_image.set_values,
    local.preflight_set_values,
    local.default_ebpf_hostrouting_set_values,
    local.default_hubble_set_values,
    local.default_hubble_ui_set_values,
    local.default_azure_set_values,
    local.default_kubeproxy_replace_set_values,
    local.default_gateway_api_set_values,
  ]
  set_values = concat(local.global_set_values...)

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

module "main_image" {
  source     = "github.com/littlejo/terraform-helm-images-set-values?ref=v0.2"
  repo_regex = var.repo_regex
  repo_url   = var.images.main
  pre_value  = "image"
  type       = "cilium"
}

module "operator_image" {
  source     = "github.com/littlejo/terraform-helm-images-set-values?ref=v0.2"
  repo_regex = var.repo_regex
  repo_url   = var.images.operator
  pre_value  = "operator.image"
  type       = "cilium"
}

module "preflight_image" {
  source     = "github.com/littlejo/terraform-helm-images-set-values?ref=v0.2"
  repo_regex = var.repo_regex
  repo_url   = var.images.preflight
  pre_value  = "preflight.image"
  type       = "cilium"
}

module "helm" {
  source               = "github.com/terraform-helm/terraform-helm?ref=0.1"
  helm_config          = local.helm_config
  set_values           = local.set_values
  set_sensitive_values = var.set_sensitive_values

  depends_on = [
    kubectl_manifest.gateway_api
  ]
}
