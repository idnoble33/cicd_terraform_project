resource "random_string" "suffix" {
  length  = 8
  special = false # not include special characters
  upper   = false # not include uppercase characters
  numeric = true  # not Include numeric characters in the string
}



resource "azurerm_key_vault" "keyvault" {
  name                        = "kv-${random_string.suffix.result}"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"
}
