output "kubeconfig" {
  description = "kubectl config file contents for this K3s cluster."
  value       = local.kubeconfig
  sensitive   = true
}
