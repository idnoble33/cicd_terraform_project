
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "subnet_prefixes" {
  description = "Address prefixes for the Subnet"
  type        = list(string)
}

variable "public_ip_name" {
  description = "Name of the Public IP"
  type        = string
}

variable "public_ip_allocation_method" {
  description = "Allocation method for the Public IP"
  type        = string
  default     = "Static"
}

variable "public_ip_sku" {
  description = "SKU for the Public IP"
  type        = string
  default     = "Standard"
}

variable "subnet_id" {
  description = "The ID of the subnet that will be used for the network interface"
  type        = string
  default     = ""
}


variable "nic_name" {
  description = "Name of the Network Interface"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "create_rg" {
  description = "Determines whether to create the resource group"
  type        = bool
  default     = false  
}

output "public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}
