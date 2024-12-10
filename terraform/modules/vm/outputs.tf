output "resource_group_name" {
  description = "The name of the resource group."
  value       = var.resource_group_name
}

output "vm_name" {
  description = "The name of the virtual machine."
  value       = azurerm_linux_virtual_machine.vm
}

output "vm_public_ip" {
  description = "The public IP address of the created VM."
  value       = var.network_public_ip # Assuming you pass this from the main module
}

