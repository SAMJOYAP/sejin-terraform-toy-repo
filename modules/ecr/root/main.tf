provider "aws" {
  region = var.region
}

module "ecr" {
  source = ".."

  nodejs_repo_name = var.nodejs_repo_name
  react_repo_name  = var.react_repo_name
}
