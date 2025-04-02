terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = "1.1.5"
    }
  }
}

resource "civo_network" "network" {
  label = "${var.cluster_name}-network"
}

resource "civo_firewall" "firewall" {
  name                 = "${var.cluster_name}-firewall"
  network_id           = civo_network.network.id
  create_default_rules = false
  depends_on           = [civo_network.network]

  ingress_rule {
    label      = "k8s"
    protocol   = "tcp"
    port_range = "6443"  # Kubernetes API server
    cidr       = [
      "31.28.78.147/32", #Tailscale VPN
      "31.24.105.13/32", #Old VPN
      "74.220.21.68/32", #Runner1
      "74.220.16.232/32", #Runner2
      "74.220.21.68/32", #SmokeTest
      "74.220.16.232/32", #SmokeTest2
    ]
    action     = "allow"
  }

  ingress_rule {
    label      = "https"
    protocol   = "tcp"
    port_range = "1-65535"  # HTTPS
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }

  egress_rule {
    label      = "allow_all_outbound"
    protocol   = "tcp"
    port_range = "1-65535"
    cidr       = ["0.0.0.0/0"]
    action     = "allow"
  }
}

resource "civo_kubernetes_cluster" "cluster" {
  name         = var.cluster_name
  cluster_type = "talos"
  write_kubeconfig = true
  firewall_id  = civo_firewall.firewall.id
  network_id   = civo_network.network.id

  pools {
    node_count = var.cluster_cpu_node_count
    size       = var.cluster_cpu_node_size
  }

  timeouts {
    create = "15m"
  }
  
  depends_on = [civo_firewall.firewall]

}


# Create a local file with the kubeconfig
resource "local_file" "cluster-config" {
  content              = civo_kubernetes_cluster.cluster.kubeconfig
  filename             = "${path.module}/kubeconfig"
  file_permission      = "0600"
  directory_permission = "0755"
}

# output the cluster api endpoint
output "cluster_id" {
  value = civo_kubernetes_cluster.cluster.id
}

output "kubeconfig" {
  value = civo_kubernetes_cluster.cluster.kubeconfig
  sensitive = false
}

output "kubeconfig_filename" {
  value = local_file.cluster-config.filename
}

# output the cluster api endpoint
output "cluster_endpoint" {
  value = civo_kubernetes_cluster.cluster.api_endpoint
}