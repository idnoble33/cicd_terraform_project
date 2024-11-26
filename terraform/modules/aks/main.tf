resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = "Standard_DS2_v2"
  }
  # service_principal {
  #   client_id     = var.client_id
  #   client_secret = var.client_secret
  # }
  
  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "production"
  }
}
