module "cluster" {
  source = "../"

  flavor_id    = "cce.s2.small"
  vpc_id       = var.vpc_id
  cluster_name = var.cluster_name
  subnet_id    = var.subnet_id

  node_pools = {
    "compute-01" = {
      flavor             = "s2.xlarge.2"
      initial_node_count = 1
      availability_zone  = "eu-de-01"
      key_pair           = "terraform"
    },
    "compute-02" = {
      flavor             = "s2.xlarge.2"
      initial_node_count = 1
      availability_zone  = "eu-de-02"
      key_pair           = "terraform"
    },
    "compute-03" = {
      flavor             = "s2.xlarge.2"
      initial_node_count = 1
      availability_zone  = "eu-de-03"
      key_pair           = "terraform"
    },
  }
}
