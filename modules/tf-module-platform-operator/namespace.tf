resource "kubernetes_namespace_v1" "operator_namespace" {
  metadata {
    name = "platform-operator"
  }
}
