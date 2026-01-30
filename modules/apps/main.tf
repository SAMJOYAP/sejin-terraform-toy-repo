locals {
  app_labels = {
    "app.kubernetes.io/part-of" = "samzo"
  }
}

resource "kubernetes_namespace" "app" {
  metadata {
    name   = var.app_namespace
    labels = local.app_labels
  }
}

resource "kubernetes_namespace" "db" {
  metadata {
    name   = var.db_namespace
    labels = local.app_labels
  }
}

resource "kubernetes_storage_class" "gp2" {
  count = var.create_storage_class ? 1 : 0

  metadata {
    name = var.storage_class_name
  }

  provisioner          = "ebs.csi.aws.com"
  reclaim_policy       = "Delete"
  volume_binding_mode  = "WaitForFirstConsumer"
  allow_volume_expansion = true

  parameters = {
    type   = "gp2"
    fsType = "ext4"
  }
}

resource "kubernetes_secret" "postgres_auth" {
  metadata {
    name      = "postgres-auth"
    namespace = kubernetes_namespace.db.metadata[0].name
  }

  data = {
    POSTGRES_USER     = base64encode(var.db_username)
    POSTGRES_PASSWORD = base64encode(var.db_password)
    POSTGRES_DB       = base64encode(var.db_name)
  }

  type = "Opaque"
}

resource "kubernetes_config_map" "postgres_init" {
  metadata {
    name      = "postgres-init"
    namespace = kubernetes_namespace.db.metadata[0].name
  }

  data = {
    "init.sql" = <<-SQL
      CREATE TABLE IF NOT EXISTS counter (
        id INT PRIMARY KEY,
        count INT NOT NULL DEFAULT 0
      );

      INSERT INTO counter (id, count)
      VALUES (1, 0)
      ON CONFLICT (id) DO NOTHING;
    SQL
  }
}

resource "kubernetes_service_v1" "postgres" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace.db.metadata[0].name
    labels    = merge(local.app_labels, { app = "postgres" })
  }

  spec {
    cluster_ip = "None"

    selector = {
      app = "postgres"
    }

    port {
      name        = "postgres"
      port        = 5432
      target_port = 5432
    }
  }
}

resource "kubernetes_stateful_set_v1" "postgres" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace.db.metadata[0].name
    labels    = merge(local.app_labels, { app = "postgres" })
  }

  spec {
    service_name = kubernetes_service_v1.postgres.metadata[0].name
    replicas     = 1

    selector {
      match_labels = {
        app = "postgres"
      }
    }

    template {
      metadata {
        labels = merge(local.app_labels, { app = "postgres" })
      }

      spec {
        container {
          name  = "postgres"
          image = var.db_image

          port {
            container_port = 5432
            name           = "postgres"
          }

          env {
            name = "POSTGRES_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.postgres_auth.metadata[0].name
                key  = "POSTGRES_USER"
              }
            }
          }

          env {
            name = "POSTGRES_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.postgres_auth.metadata[0].name
                key  = "POSTGRES_PASSWORD"
              }
            }
          }

          env {
            name = "POSTGRES_DB"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.postgres_auth.metadata[0].name
                key  = "POSTGRES_DB"
              }
            }
          }

          volume_mount {
            name       = "postgres-data"
            mount_path = "/var/lib/postgresql/data"
          }

          volume_mount {
            name       = "postgres-init"
            mount_path = "/docker-entrypoint-initdb.d"
            read_only  = true
          }
        }

        volume {
          name = "postgres-init"

          config_map {
            name = kubernetes_config_map.postgres_init.metadata[0].name
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "postgres-data"
      }

      spec {
        access_modes       = ["ReadWriteOnce"]
        storage_class_name = var.storage_class_name

        resources {
          requests = {
            storage = var.db_storage_size
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "postgres_alias" {
  metadata {
    name      = "postgres"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = merge(local.app_labels, { app = "postgres" })
  }

  spec {
    type         = "ExternalName"
    external_name = "postgres.${var.db_namespace}.svc.cluster.local"

    port {
      name        = "postgres"
      port        = 5432
      target_port = 5432
    }
  }
}

resource "kubernetes_deployment_v1" "backend" {
  metadata {
    name      = "backend"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = merge(local.app_labels, { app = "backend" })
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = merge(local.app_labels, { app = "backend" })
      }

      spec {
        container {
          name  = "backend"
          image = var.backend_image

          port {
            container_port = var.backend_port
            name           = "http"
          }

          env {
            name  = "POSTGRES_USER"
            value = var.db_username
          }

          env {
            name  = "POSTGRES_PASSWORD"
            value = var.db_password
          }

          env {
            name  = "POSTGRES_DB"
            value = var.db_name
          }

          env {
            name  = "POSTGRES_HOST"
            value = "postgres"
          }

          env {
            name  = "POSTGRES_PORT"
            value = "5432"
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "backend" {
  metadata {
    name      = "backend"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = merge(local.app_labels, { app = "backend" })
  }

  spec {
    selector = {
      app = "backend"
    }

    port {
      name        = "http"
      port        = var.backend_port
      target_port = var.backend_port
    }
  }
}

resource "kubernetes_deployment_v1" "frontend" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = merge(local.app_labels, { app = "frontend" })
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = merge(local.app_labels, { app = "frontend" })
      }

      spec {
        container {
          name  = "frontend"
          image = var.frontend_image

          port {
            container_port = var.frontend_port
            name           = "http"
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "frontend" {
  metadata {
    name      = "frontend"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels    = merge(local.app_labels, { app = "frontend" })
  }

  spec {
    selector = {
      app = "frontend"
    }

    port {
      name        = "http"
      port        = var.frontend_port
      target_port = var.frontend_port
    }
  }
}

resource "kubernetes_ingress_v1" "app" {
  metadata {
    name      = "app-ingress"
    namespace = kubernetes_namespace.app.metadata[0].name

    annotations = {
      "alb.ingress.kubernetes.io/scheme"        = var.alb_scheme
      "alb.ingress.kubernetes.io/target-type"   = var.alb_target_type
      "alb.ingress.kubernetes.io/listen-ports"  = "[{\"HTTP\":80}]"
    }
  }

  spec {
    ingress_class_name = var.ingress_class_name

    rule {
      http {
        path {
          path      = "/api"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service_v1.backend.metadata[0].name
              port {
                number = var.backend_port
              }
            }
          }
        }

        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service_v1.frontend.metadata[0].name
              port {
                number = var.frontend_port
              }
            }
          }
        }
      }
    }
  }
}
