variable "cluster_name" {
  description = "The name of the Kubernetes cluster to create."
  type        = string
}

variable "flavor_id" {
  description = "Cluster specifications."
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC used to create the node."
  type        = string
}

variable "subnet_id" {
  description = "The Network ID of the subnet used to create the node."
  type        = string
}

variable "cluster_version" {
  description = "The K8s version to use."
  type        = string
  default     = null
}

variable "cluster_type" {
  description = "Cluster Type, possible values are VirtualMachine and BareMetal."
  type        = string
  default     = "VirtualMachine"
}

variable "container_network_type" {
  description = "Container network type."
  type        = string
  default     = "overlay_l2"
}

variable "authentication_mode" {
  description = "Authentication mode of the cluster, possible values are rbac and authenticating_proxy."
  type        = string
  default     = "rbac"
}

variable "multi_az" {
  description = "Enable multiple AZs for the cluster, only when using HA flavors."
  type        = bool
  default     = false
}

variable "node_pools" {
  description = "Map of map of node pools to create."
  type        = map(map(any))
  default     = {}
}
