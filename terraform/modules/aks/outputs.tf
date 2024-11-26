output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_identity" {
  description = "System-assigned identity of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.identity[0].principal_id
}
