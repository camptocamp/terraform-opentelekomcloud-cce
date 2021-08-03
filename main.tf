locals {
  kubeconfig = <<EOT
kind: Config
apiVersion: v1
clusters:
  - cluster:
      server: ${opentelekomcloud_cce_cluster_v3.cluster.internal}
      certificate-authority-data: ${opentelekomcloud_cce_cluster_v3.cluster.certificate_clusters.0.certificate_authority_data}
    name: internalCluster
users:
  - name: user
    user:
      client-certificate-data: ${opentelekomcloud_cce_cluster_v3.cluster.certificate_users.0.client_certificate_data}
      client-key-data: ${opentelekomcloud_cce_cluster_v3.cluster.certificate_users.0.client_key_data}
contexts:
  - name: internal
    context:
      cluster: internalCluster
      user: user
current-context: internal
EOT
}

resource "opentelekomcloud_cce_cluster_v3" "cluster" {
  name = var.cluster_name

  cluster_version        = var.cluster_version
  cluster_type           = var.cluster_type
  flavor_id              = var.flavor_id
  vpc_id                 = var.vpc_id
  subnet_id              = var.subnet_id
  container_network_type = var.container_network_type
  authentication_mode    = var.authentication_mode
  multi_az               = var.multi_az
}

resource "opentelekomcloud_cce_node_pool_v3" "node_pool" {
  for_each = var.node_pools

  cluster_id         = opentelekomcloud_cce_cluster_v3.cluster.id
  name               = each.key
  os                 = "EulerOS 2.5"
  flavor             = each.value["flavor"]
  initial_node_count = each.value["initial_node_count"]
  availability_zone  = each.value["availability_zone"]
  key_pair           = each.value["key_pair"]

  preinstall  = try(each.value["preinstall"], null)
  postinstall = try(each.value["postinstall"], null)

  scale_enable             = true
  min_node_count           = 1
  max_node_count           = 9
  scale_down_cooldown_time = 100
  priority                 = 1

  root_volume {
    size       = 40
    volumetype = "SSD"
  }

  data_volumes {
    size       = 100
    volumetype = "SSD"
  }
}

data "opentelekomcloud_cce_node_ids_v3" "node_ids" {
  cluster_id = opentelekomcloud_cce_cluster_v3.cluster.id
}

data "opentelekomcloud_cce_node_v3" "node" {
  for_each = data.opentelekomcloud_cce_node_ids_v3.node_ids.ids

  cluster_id = opentelekomcloud_cce_cluster_v3.cluster.id
  node_id    = each.value
}

