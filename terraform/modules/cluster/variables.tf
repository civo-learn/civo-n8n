variable "cluster_name" {
  type        = string
  description = "The name of the Kubernetes cluster to create"
}

variable "cluster_cpu_node_count" {
  type        = number
  description = "Number of CPU nodes to provision in the cluster"
}

variable "cluster_cpu_node_size" {
  type        = string
  description = "Size specification for CPU nodes in the cluster"
}
