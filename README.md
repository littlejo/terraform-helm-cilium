<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.7.1 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_helm"></a> [helm](#module\_helm) | github.com/terraform-helm/terraform-helm | 0.1 |
| <a name="module_main_image"></a> [main\_image](#module\_main\_image) | github.com/littlejo/terraform-helm-images-set-values | v0.2 |
| <a name="module_operator_image"></a> [operator\_image](#module\_operator\_image) | github.com/littlejo/terraform-helm-images-set-values | v0.2 |
| <a name="module_preflight_image"></a> [preflight\_image](#module\_preflight\_image) | github.com/littlejo/terraform-helm-images-set-values | v0.2 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_resource_group"></a> [azure\_resource\_group](#input\_azure\_resource\_group) | Suppose that you use aks cluster | `string` | `null` | no |
| <a name="input_chart"></a> [chart](#input\_chart) | Chart of helm release | `string` | `"cilium"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Create namespace ? | `bool` | `false` | no |
| <a name="input_default_values"></a> [default\_values](#input\_default\_values) | n/a | `map(list(object({ name = string, value = string })))` | <pre>{<br>  "azure": [<br>    {<br>      "name": "nodeinit.enabled",<br>      "value": "true"<br>    },<br>    {<br>      "name": "aksbyocni.enabled",<br>      "value": "true"<br>    }<br>  ],<br>  "ebpf_hostrouting": [<br>    {<br>      "name": "bpf.masquerade",<br>      "value": "true"<br>    }<br>  ],<br>  "hubble": [<br>    {<br>      "name": "hubble.relay.enabled",<br>      "value": "true"<br>    }<br>  ],<br>  "hubble_ui": [<br>    {<br>      "name": "hubble.ui.enabled",<br>      "value": "true"<br>    }<br>  ],<br>  "kubeproxy_replace": [<br>    {<br>      "name": "kubeProxyReplacement",<br>      "value": "true"<br>    }<br>  ],<br>  "preflight": [<br>    {<br>      "name": "preflight.enabled",<br>      "value": "true"<br>    },<br>    {<br>      "name": "agent",<br>      "value": "false"<br>    },<br>    {<br>      "name": "operator.enabled",<br>      "value": "false"<br>    }<br>  ]<br>}</pre> | no |
| <a name="input_ebpf_hostrouting"></a> [ebpf\_hostrouting](#input\_ebpf\_hostrouting) | Do you want ebpf hostrouting? | `bool` | `false` | no |
| <a name="input_helm_config"></a> [helm\_config](#input\_helm\_config) | Map of helm config | `map(any)` | `{}` | no |
| <a name="input_hubble"></a> [hubble](#input\_hubble) | Do you want hubble? | `bool` | `false` | no |
| <a name="input_hubble_ui"></a> [hubble\_ui](#input\_hubble\_ui) | Do you want hubble ui? | `bool` | `false` | no |
| <a name="input_images"></a> [images](#input\_images) | Map of images | <pre>object({<br>    main      = optional(string)<br>    operator  = optional(string)<br>    preflight = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_kubeproxy_replace_host"></a> [kubeproxy\_replace\_host](#input\_kubeproxy\_replace\_host) | kubeproxy replacement, format: $HOST:$PORT | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of helm release | `string` | `"cilium"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | namespace of helm release | `string` | `"kube-system"` | no |
| <a name="input_preflight"></a> [preflight](#input\_preflight) | Is it preflight? | `bool` | `false` | no |
| <a name="input_release_version"></a> [release\_version](#input\_release\_version) | version of helm release | `string` | `null` | no |
| <a name="input_repo_regex"></a> [repo\_regex](#input\_repo\_regex) | Repo regex to identifier different part of the string | `string` | `"^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Url of repository | `string` | `"https://helm.cilium.io/"` | no |
| <a name="input_set_sensitive_values"></a> [set\_sensitive\_values](#input\_set\_sensitive\_values) | Forced set\_sensitive values | `any` | `[]` | no |
| <a name="input_set_values"></a> [set\_values](#input\_set\_values) | Forced set values | `any` | `[]` | no |
| <a name="input_values"></a> [values](#input\_values) | Values | `list(any)` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->