terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "1.1.5"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.14.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.31.0"
    }
  }
}

provider "civo" {
  token  = var.civo_token
  region = var.region
}

module "kubernetes_cluster" {
  source = "../../modules/cluster"
  cluster_name          = var.cluster_name
  cluster_cpu_node_count = var.cluster_cpu_node_count
  cluster_cpu_node_size  = var.cluster_cpu_node_size
}

module "n8n" {
  source = "../../modules/n8n"
  depends_on = [ module.kubernetes_cluster ]
}


provider "helm" {
  kubernetes {
    host                   = module.kubernetes_cluster.cluster_endpoint
    client_certificate     = base64decode(yamldecode(module.kubernetes_cluster.kubeconfig).users[0].user.client-certificate-data)
    client_key             = base64decode(yamldecode(module.kubernetes_cluster.kubeconfig).users[0].user.client-key-data)
    cluster_ca_certificate = base64decode(yamldecode(module.kubernetes_cluster.kubeconfig).clusters[0].cluster.certificate-authority-data)
  }
}

provider "kubernetes" {
  host                   = module.kubernetes_cluster.cluster_endpoint
  client_certificate     = base64decode(yamldecode(module.kubernetes_cluster.kubeconfig).users[0].user.client-certificate-data)
  client_key             = base64decode(yamldecode(module.kubernetes_cluster.kubeconfig).users[0].user.client-key-data)
  cluster_ca_certificate = base64decode(yamldecode(module.kubernetes_cluster.kubeconfig).clusters[0].cluster.certificate-authority-data)
}