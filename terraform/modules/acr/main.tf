resource "azurerm_container_registry" "acr" {
  name                = "myacrname123"
  location            = var.location            # From resource_group object
  resource_group_name = var.resource_group_name # From resource_group_name string
  sku                 = "Basic"
  # admin_enabled       = var.admin_enabled

}
