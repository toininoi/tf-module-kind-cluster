resource "kubernetes_config_map_v1" "vault_ca_bundle" {
  metadata {
    name      = "vault-ca-bundle"
    namespace = kubernetes_namespace_v1.operator_namespace.metadata[0].name
  }

  data = {
    "ca-bundle.crt" = var.vault_ca_pem
  }
}
