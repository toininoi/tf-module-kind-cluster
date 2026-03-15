variable "gitea_registry" {
  description = "Hostname:port of the Gitea registry"
  type        = string
  default     = "gitea.cacetinho.internal.infra:3000"
}

variable "vault_ca_pem" {
  description = "CA used to connect to local Gitea"
  type        = string
}

variable "ca_tmp_file" {
  description = "Local ca pem file"
  type        = string
}

variable "operator_version" {
  description = "Helm chart version to install"
  type        = string
  default     = "0.1.0"
}

variable "operator_image_tag" {
  description = "Image tag (commit SHA or semver) for the platform-operator"
  type        = string
  default     = "a25afdfc8faa96769fb73489481d995061a3512c"
}

