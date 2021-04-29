provider "aws" {
  region     = var.aws_region
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "eks-terraformtfstate"
    key    = "terraform.tfstate"
    region = "us-east-2"
  }
}

# Retrieve EKS cluster configuration
data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    command     = "aws"
  }
}

resource "kubernetes_namespace" "prometheus" {
  metadata {
    name = "prometheus"
  }
}

resource "kubernetes_namespace" "grafana" {
  metadata {
    name = "app-grafana"
  }
}

resource "kubernetes_namespace" "goldpinger" {
  metadata {
    annotations = {
      name = "app-goldpinger"
    }
    name = "app-goldpinger"
  }
}

resource "kubernetes_service" "prometheus" {
  metadata {
    name      = kubernetes_namespace.prometheus.metadata.0.name
    namespace = kubernetes_namespace.prometheus.metadata.0.name
  }
  spec {
    selector = {
      component = "server"
    }
    port {
      port        = 8080
      target_port = 9090
    }
    type = "LoadBalancer"
  }
}