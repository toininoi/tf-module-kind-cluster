data "vault_kv_secret_v2" "platform_operator" {
  mount = "secret"
  name  = "platform-operator"
}

data "vault_kv_secret_v2" "gitea_dockerconfig" {
  mount = "secret"
  name  = "gitea/dockerconfig"

  depends_on = [vault_kv_secret_v2.gitea_dockerconfig]
}
