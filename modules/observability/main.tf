resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.monitoring_namespace
  }
}

resource "aws_cloudwatch_log_group" "container_insights_application" {
  name              = "/aws/containerinsights/${var.cluster_name}/application"
  retention_in_days = 1
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  set {
    name  = "grafana.service.type"
    value = "ClusterIP"
  }
}

resource "helm_release" "amazon_cloudwatch_observability" {
  name             = "amazon-cloudwatch-observability"
  repository       = "https://aws-observability.github.io/helm-charts"
  chart            = "amazon-cloudwatch-observability"
  namespace        = "amazon-cloudwatch"
  create_namespace = true

  values = [file("${path.module}/cloudwatch-values.yaml")]

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.region
  }

  depends_on = [aws_cloudwatch_log_group.container_insights_application]
}
