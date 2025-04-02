##################################
# Cluster Configuration Variables #
##################################

# The name of the Kubernetes cluster to create
variable "cluster_name" {
    type        = string
    default     = "civo-neightn-cluster"
    description = "The name of the Kubernetes cluster to create"
}

# Number of CPU nodes to provision in the cluster
variable "cluster_cpu_node_count" {
    type        = number
    default     = 1
    description = "Number of CPU nodes to provision in the cluster"
}

# Size specification for CPU nodes in the cluster
variable "cluster_cpu_node_size" {
    type        = string
    default     = "g4s.kube.large" 
    description = "Size specification for CPU nodes in the cluster"
}

# Region where the cluster will be provisioned
variable "region" {
    type        = string
    default     = "LON2"
    description = "Region where the cluster will be provisioned"
}


##############
# Miscellaneous Variables #
##############

# Civo API token (set in terraform.tfvars)
variable "civo_token" {
    description = "Civo API token"
}
