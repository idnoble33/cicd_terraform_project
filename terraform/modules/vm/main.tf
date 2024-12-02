resource "azurerm_linux_virtual_machine" "vm" {
  count                = 1
  name                 = "vm-${count.index}"
  resource_group_name  = var.resource_group_name
  location             = var.location
  size                 = var.vm_size

  # OS Profile
  admin_username       = "azureuser"  # Specify the admin username

  # Linux Configuration for SSH
  admin_ssh_key {
    username   = "azureuser"  # Must match admin_username
    public_key = file(var.ssh_public_key_path)  # Path to your public key file
  }

  # OS Disk Configuration
  os_disk {
    name                = "${var.resource_group_name}-osdisk-${count.index}"
    caching             = "ReadWrite"
    storage_account_type = "Standard_LRS"  # Required attribute
    disk_size_gb        = var.os_disk_size  # Parameterized disk size
  }

  # Source Image Configuration (Ubuntu 22.04 LTS)
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # Network Interface Configuration
  network_interface_ids = [var.network_interface_id]  # Use the passed NIC ID
}
