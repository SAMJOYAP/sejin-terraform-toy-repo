data "terraform_remote_state" "cluster" {
  backend = "local"
  config = {
    path = "../cluster/root/terraform.tfstate"
  }
}

module "apps" {
  source = ".."

  app_namespace        = var.app_namespace
  db_namespace         = var.db_namespace

  backend_image        = var.backend_image
  frontend_image       = var.frontend_image
  backend_port         = var.backend_port
  frontend_port        = var.frontend_port

  db_image             = var.db_image
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  db_storage_size      = var.db_storage_size
  storage_class_name   = var.storage_class_name
  create_storage_class = var.create_storage_class

  ingress_class_name   = var.ingress_class_name
  alb_scheme           = var.alb_scheme
  alb_target_type      = var.alb_target_type
}
