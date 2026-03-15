resource "kubernetes_manifest" "vault_connection" {
  manifest = {
    apiVersion = "security.platform.io/v1alpha1"
    kind       = "VaultConnection"

    metadata = {
      name = "${var.cluster_name}-vc"
    }

    spec = {
      vaultUrl  = var.vault_addr
      authPath  = vault_auth_backend.kubernetes_eso.path
      mountPath = var.vault_auth_path
      vaultRole = vault_kubernetes_auth_backend_role.eso_roke.role_name
    }
  }

}
