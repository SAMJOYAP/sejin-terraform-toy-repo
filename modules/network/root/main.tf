provider "aws" {
  region = var.region
}

module "network" {
  source = ".."

  cluster_name       = var.cluster_name
  vpc_cidr           = var.vpc_cidr
  region             = var.region
  enable_s3_endpoint = var.enable_s3_endpoint
}
