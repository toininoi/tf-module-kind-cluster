locals {
  registry_user     = data.vault_kv_secret_v2.platform_operator.data["registry_user"]
  registry_password = data.vault_kv_secret_v2.platform_operator.data["registry_password"]

  dockerconfig = jsonencode({
    auths = {
      "${var.gitea_registry}" = {
        username = local.registry_user
        password = local.registry_password
        auth     = base64encode("${local.registry_user}:${local.registry_password}")
      }
    }
  })
}
