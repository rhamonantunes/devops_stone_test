terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.1.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.1.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "3.37.0"
    }
  }
  required_version = "~> 0.15"
}