variable "cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the cluster"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
}

variable "vm_size" {
  description = "VM size for the default node pool"
  type        = string
  default = "Standard_NC40ads_H100_v5"
}

variable "location" {
  type = string
}
variable "resource_group_name" {
  description = "The name of the resource group where the Azure Container Registry will be created."
  type        = string
}
