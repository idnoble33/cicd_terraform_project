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
#   resource "azurerm_virtual_machine" "vm" {
#   count               = 1
#   name                = "vm-${count.index}"
#   resource_group_name = var.resource_group_name
#   location            = var.location
#   vm_size             = var.vm_size


#   # OS Profile
#   os_profile {
#     computer_name  = "vm-${count.index}"
#     admin_username = "azureuser"  # Specify the admin username

#     admin_ssh_key {
#       username   = "azureuser"  # Must match admin_username
#       public_key = file(var.ssh_public_key_path)  # Path to your public key file
#     }
#   }

#   # Linux Configuration
#   os_profile_linux_config {
#     disable_password_authentication = true  # Disable password authentication
#   }

#   # Storage OS Disk Configuration
#   storage_os_disk {
#     name              = "${var.resource_group_name}-osdisk-${count.index}"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#   }

#   # Source Image Configuration
#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "22.04-LTS"  # Use a recent LTS version
#     version   = "latest"
#   }

#   # Network Interface Configuration
#   network_interface_ids = [var.network_interface_id]
# }
resource "azurerm_linux_virtual_machine" "vm" {
  count                = 1
  name                 = "vm-${count.index}"
  resource_group_name  = var.resource_group_name
  location             = var.location
  size                 = var.vm_size

  # OS Profile
  admin_username       = "azureuser"  # Specify the admin username

  # Linux Configuration
  admin_ssh_key {
    username   = "azureuser"  # Must match admin_username
    public_key = file(var.ssh_public_key_path)  # Path to your public key file
  }

 # Storage OS Disk Configuration
  os_disk {
    name              = "${var.resource_group_name}-osdisk-${count.index}"
    caching           = "ReadWrite"
    # disk_size_gb     = 30  # Specify the disk size in GB
    storage_account_type = "Standard_LRS"  # Required attribute
  }

  # Source Image Configuration
 source_image_reference {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "22.04-LTS"  # or try "20.04-LTS" if necessary
  version   = "latest"  # You can also specify a specific version if needed
}

  # Network Interface Configuration
  network_interface_ids = [var.network_interface_id]
}