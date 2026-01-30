data "terraform_remote_state" "network" {
  backend = "local"
  config = {
    path = "../network/root/terraform.tfstate"
  }
}

data "terraform_remote_state" "cluster" {
  backend = "local"
  config = {
    path = "../cluster/root/terraform.tfstate"
  }
}

module "addons" {
  source = ".."

  cluster_name            = data.terraform_remote_state.cluster.outputs.cluster_name
  region                  = var.region
  vpc_id                  = data.terraform_remote_state.network.outputs.vpc_id
  oidc_provider_arn       = data.terraform_remote_state.cluster.outputs.oidc_provider_arn
  lb_controller_namespace = var.lb_controller_namespace
  enable_external_dns     = var.enable_external_dns
  external_dns_namespace  = var.external_dns_namespace
  domain_name             = var.domain_name
}
