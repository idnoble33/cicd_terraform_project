output "resource_group_name" {
  description = "The name of the resource group used by the network module"
  value       = var.resource_group_name
}

output "nic_id" {
  description = "The ID of the network interface."
  value       = azurerm_network_interface.nic.id # Ensure this matches your network interface resource
}

output "public_ip_address" {
  description = "The public IP address of the created VM."
  value       = azurerm_public_ip.public_ip.ip_address
}

output "network_interface_id" {
  value = azurerm_network_interface.nic.id
}

output "subnet_id" {
  value = azurerm_subnet.subnet.id
}
