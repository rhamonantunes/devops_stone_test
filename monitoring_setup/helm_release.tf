provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = "prometheus"

  set {
    name  = "alertmanager.persistentVolume.storageClass"
    value = "gp2"
  }

  set {
    name  = "server.persistentVolume.storageClass"
    value = "gp2"
  }
  depends_on = [kubernetes_namespace.prometheus]

}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = "app-grafana"

  values = [
    file("${path.module}/grafana-values.yaml")
  ]

  set {
    name  = "alertmanager.persistentVolume.storageClass"
    value = "gp2"
  }

  set {
    name  = "persistence.enabled"
    value = "gp2"
  }

  set {
    name  = "adminPassword"
    value = "EKS!StOnE"
  }

  set {
    name  = "service.type"
    value = "LoadBalancer"
  }
  depends_on = [kubernetes_namespace.grafana, helm_release.prometheus]

}

resource "helm_release" "goldpinger" {
  name       = "goldpinger"
  repository = "https://okgolove.github.io/helm-charts"
  chart      = "goldpinger"
  version    = "4.1.1"
  namespace  = "app-goldpinger"

  values = [
    file("${path.module}/goldpinger-values.yaml")
  ]

  depends_on = [kubernetes_namespace.goldpinger, helm_release.prometheus]
}