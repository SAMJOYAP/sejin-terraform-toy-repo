provider "aws" {
  region = var.region
}

module "dns" {
  source = ".."

  domain_name                   = var.domain_name
  create_hosted_zone            = var.create_hosted_zone
  enable_acm                    = var.enable_acm
  acm_subject_alternative_names = var.acm_subject_alternative_names
}
