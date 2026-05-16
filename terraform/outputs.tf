output "namespace" {
  value = kubernetes_namespace.crewmeister.metadata[0].name
}