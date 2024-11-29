# AKS Variables
variable "aks_name" {
  description = "Name of the AKS cluster"
  default     = "example-aks"
}

variable "cluster_name" {
  description = "Cluster name for AKS"
  default     = "example-cluster"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  default     = 2
}

variable "vm_size" {
  description = "VM size for the AKS node pool"
  default     = "Standard_D4s_v3"
}

variable "service_cidr" {
  description = "Service CIDR for AKS"
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "DNS service IP for AKS"
  default     = "10.0.0.10"
}

variable "docker_bridge_cidr" {
  description = "Docker bridge CIDR for AKS"
  default     = "172.17.0.1/16"
}

variable "dns_prefix" {
  description = "DNS prefix for AKS"
  default     = "example-dns"
}

# Resource Group Variables
variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "Idowu-Candidate"
}

variable "location" {
  description = "Azure location for resources"
  default     = "West US"
}

# VM Variables
variable "admin_username" {
  description = "Administrator username for the VM"
  default     = "azureuser"
}


variable "admin_password" {
  description = "The admin password for the VM."
  type        = string
}

variable "client_id" {
  description = "The client ID of the Service Principal"
  type        = string
}

variable "client_secret" {
  description = "The client secret of the Service Principal"
  type        = string
}

# variable "ssh_public_key_path" {
#   description = "Path to the SSH public key"
#   default     = "/Users/noble/.ssh/id_rsa_new.pub"
# }
variable "create_rg" {
  description = "Determines whether to create the resource group"
  type        = bool
  default     = false
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key."
  type        = string
}

variable "ssh_private_key_path" {
  description = "The path to the SSH private key."
  type        = string
}

variable "network_interface_id" {
  description = "The ID of the network interface."
  type        = string
}