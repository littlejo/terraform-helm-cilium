variable "name" {
  description = "Name of helm release"
  type        = string
  default     = "cilium"
}

variable "repository" {
  description = "Url of repository"
  type        = string
  default     = "https://helm.cilium.io/"
}

variable "chart" {
  description = "Chart of helm release"
  type        = string
  default     = "cilium"
}

variable "namespace" {
  description = "namespace of helm release"
  type        = string
  default     = "kube-system"
}

variable "create_namespace" {
  description = "Create namespace ?"
  type        = bool
  default     = false
}

variable "release_version" {
  description = "version of helm release"
  type        = string
  default     = null
}

variable "images" {
  description = "Map of images"
  type = object({
    main      = optional(string)
    operator  = optional(string)
    preflight = optional(string)
  })
  default = {}
}

variable "values" {
  description = "Values"
  type        = list(any)
  default     = []
}

variable "set_values" {
  description = "Forced set values"
  type        = any
  default     = []
}

variable "set_sensitive_values" {
  description = "Forced set_sensitive values"
  type        = any
  default     = []
}

variable "repo_regex" {
  description = "Repo regex to identifier different part of the string"
  type        = string
  default     = "^(?:(?P<url>[^/]+))?(?:/(?P<image>[^:]*))??(?::(?P<tag>[^:]*))"
}

variable "helm_config" {
  description = "Map of helm config"
  type        = map(any)
  default     = {}
}

variable "preflight" {
  description = "Is it preflight?"
  type        = bool
  default     = false
}
