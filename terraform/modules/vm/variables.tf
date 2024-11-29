# variable "ssh_key_path" {
#   description = "The path to the SSH private key file used for SSH authentication"
#   type        = string
#   default     = "/Users/noble/.ssh/id_rsa_new.pub"  # Modify this to the appropriate default or leave it without the default for input
# }
# variable "resource_group_name" {
#   description = "The name of the resource group where the Azure Container Registry will be created."
#   type        = string
# }
# variable "location" {
#   description = "The name of the location."
#   type        = string
# }

# variable "vm_size" {
#   description = "The name of the resource group where the Azure Container Registry will be created."
#   type        = string
# }
# variable "ssh_public_key_path" {
#   description = "The path to the SSH public key."
#   type        = string
# }

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the resources."
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
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
variable "network_public_ip" {
  description = "The public IP address of the created VM."
  type        = string
  default = "netinterip12345"
}