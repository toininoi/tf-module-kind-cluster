resource "vault_kv_secret_v2" "gitea_dockerconfig" {
  mount = "secret"
  name  = "gitea/dockerconfig"

  data_json = jsonencode({
    ".dockerconfigjson" = local.dockerconfig
  })
}
