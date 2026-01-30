provider "aws" {
  region = var.region
}

data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../network/root/terraform.tfstate"
  }
}

module "cluster" {
  source = ".."

  cluster_name                = var.cluster_name
  cluster_version             = var.cluster_version
  cluster_public_access_cidrs = var.cluster_public_access_cidrs
  vpc_id                      = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids                  = data.terraform_remote_state.network.outputs.private_subnets

  node_instance_type = var.node_instance_type
  node_min_size      = var.node_min_size
  node_max_size      = var.node_max_size
  node_desired_size  = var.node_desired_size

  create_cloudwatch_log_group = var.create_cloudwatch_log_group
}
