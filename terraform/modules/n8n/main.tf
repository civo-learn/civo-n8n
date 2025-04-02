terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }
    civo = {
      source  = "civo/civo"
      version = "1.1.5"
    }
  }
}

resource "kubernetes_namespace" "n8n-namespace" {
  metadata {
    annotations = {
      name = "n8n"
    }
    name = "n8n"
  }
}


resource "helm_release" "n8n-helm" {
  name       = "n8n-helm"
  chart      = "../../../helm/n8n"
  namespace  = kubernetes_namespace.n8n-namespace.id
  replace   = true
  force_update = true
  wait       = true  
  values = [file("${path.module}/values.yaml")]
  
}
