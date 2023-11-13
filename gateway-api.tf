data "http" "gateway_api" {
  for_each = var.gateway_api ? toset(var.gateway_api_crd_urls) : toset([])
  url      = each.key
  request_headers = {
    Accept = "text/plain"
  }
}

resource "kubectl_manifest" "gateway_api" {
  for_each  = var.gateway_api ? toset(var.gateway_api_crd_urls) : toset([])
  yaml_body = data.http.gateway_api[each.key].body
}
