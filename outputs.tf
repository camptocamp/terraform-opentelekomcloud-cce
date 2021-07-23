output "kubeconfig" {
  description = "kubectl config file contents for this K3s cluster."
  value       = local.kubeconfig
  sensitive   = true
}

output "cluster_id" {
  description = "this cluster id"
  value       = opentelekomcloud_cce_cluster_v3.cluster.id
}

output "node_public_ips" {
  description = "nodes public IPs"
  value       = opentelekomcloud_cce_node_pool_v3.node[*].public_ip
}
