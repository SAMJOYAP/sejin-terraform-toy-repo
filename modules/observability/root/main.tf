data "terraform_remote_state" "cluster" {
  backend = "local"
  config = {
    path = "../cluster/root/terraform.tfstate"
  }
}

module "observability" {
  source = ".."

  cluster_name         = data.terraform_remote_state.cluster.outputs.cluster_name
  region               = var.region
  monitoring_namespace = var.monitoring_namespace
}
