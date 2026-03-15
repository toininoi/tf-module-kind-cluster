resource "helm_release" "platform_operator" {
  name             = "platform-operator"
  namespace        = kubernetes_namespace_v1.operator_namespace.metadata[0].name
  create_namespace = false
  repository       = "https://gitea.cacetinho.internal.infra:3000/api/packages/Platform-Engineering/helm"
  chart            = "platform-operator"
  version          = var.operator_version

  # Point to the full image including the registry host
  set = [

    {
      name  = "manager.image.repository"
      value = "gitea.cacetinho.internal.infra:3000/platform-engineering/platform-operator"
    },

    {
      name  = "manager.image.tag"
      value = var.operator_image_tag
    },

    {
      name  = "manager.image.pullPolicy"
      value = "IfNotPresent"
    },

    # Wire in the pull secret created by k8s_secrets.tf
    {
      name  = "manager.imagePullSecrets[0].name"
      value = kubernetes_secret_v1.gitea_registry.metadata[0].name
    },

    # Mount the Vault CA bundle so the operator can reach Gitea over TLS
    # at runtime (e.g. for OCI calls, webhook validation, etc.)
    {
      name  = "manager.extraVolumes[0].name"
      value = "vault-ca-bundle"
    },

    {
      name  = "manager.extraVolumes[0].configMap.name"
      value = kubernetes_config_map_v1.vault_ca_bundle.metadata[0].name
    },

    {
      name  = "manager.extraVolumeMounts[0].name"
      value = "vault-ca-bundle"
    },

    {
      name  = "manager.extraVolumeMounts[0].mountPath"
      value = "/etc/ssl/certs/vault-ca-bundle.crt"
    },

    {
      name  = "manager.extraVolumeMounts[0].subPath"
      value = "ca-bundle.crt"
    },

    {
      name  = "manager.extraVolumeMounts[0].readOnly"
      value = "true"
    },

    # Pass the CA path to the operator process via env so Go's TLS stack picks it up
    {
      name  = "manager.env[0].name"
      value = "SSL_CERT_FILE"
    },

    {
      name  = "manager.env[0].value"
      value = "/etc/ssl/certs/vault-ca-bundle.crt"
    },
  ]

  repository_ca_file = var.ca_tmp_file
}
