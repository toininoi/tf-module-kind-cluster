resource "kubernetes_secret_v1" "gitea_registry" {
  metadata {
    name      = "gitea-registry-credentials"
    namespace = kubernetes_namespace_v1.operator_namespace.metadata[0].name
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = data.vault_kv_secret_v2.gitea_dockerconfig.data[".dockerconfigjson"]
  }
}
