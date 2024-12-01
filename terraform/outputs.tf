
output "vm_public_ip" {
  value = module.network.public_ip
}

output "acr_login_server" {
  value = module.acr.acr_login_server
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster"
  value       = module.aks.aks_cluster_name
}

output "keyvault_uri" {
  value = module.keyvault.keyvault_uri
}
output "ssh_public_key_path" {
  value = file(var.ssh_public_key_path)
}

