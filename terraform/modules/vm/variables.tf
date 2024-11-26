variable "ssh_key_path" {
  description = "The path to the SSH private key file used for SSH authentication"
  type        = string
  default     = "/Users/noble/.ssh/id_rsa_new.pub"  # Modify this to the appropriate default or leave it without the default for input
}
variable "resource_group_name" {
  description = "The name of the resource group where the Azure Container Registry will be created."
  type        = string
}
variable "location" {
  description = "The name of the location."
  type        = string
}

variable "vm_size" {
  description = "The name of the resource group where the Azure Container Registry will be created."
  type        = string
}
