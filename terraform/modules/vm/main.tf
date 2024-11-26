# resource "azurerm_linux_virtual_machine" "vm" {
#   name                = var.vm_name
#   resource_group_name = var.resource_group_name  # Use resource group name
#   location            = var.location  # Use resource group location
#   size                = var.vm_size

#   admin_username      = var.admin_username
#   admin_password      = var.admin_password

#   network_interface_ids = var.network_interface_ids

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#     disk_size_gb         = 30
#   }
  resource "azurerm_linux_virtual_machine" "vm" {
  count                = 1
  name                 = "jenkins-vm-${count.index}"
  resource_group_name  = var.resource_group_name
  location             = var.location
  size                 = var.vm_size
  admin_username       = "azureuser"
  admin_ssh_key {
    public_key = file(var.ssh_public_key_path)
  }
  network_interface_ids = [azurerm_network_interface.nic.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}


  # Provide the SSH key configuration
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_key_path)
  }
  # Disable password authentication and use SSH keys
  disable_password_authentication = true

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
