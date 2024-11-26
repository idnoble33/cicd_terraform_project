
variable "keyvault_name" {
  description = "Name of the Key Vault"
    type        = string

}

variable "location" {
  description = "The location where the Key Vault will be created."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Key Vault."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group to create the Key Vault in."
  type        = string
}
