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
  default     = "netinterip12345"
}

variable "os_disk_size" {
  description = "The size of the OS disk in GB"
  type        = number
  default     = 40 # Default disk size
}
variable "subnet_id" {
  description = "The ID of the subnet the NIC will be attached to"
  type        = string
  default     = "10.0.1.0/24"
}