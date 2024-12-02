# Provider Configuration
provider "azurerm" {
  features {
    # resource_group {
    #   prevent_deletion_if_contains_resources = false
    # }

  }
  subscription_id = "54557d68-29ef-4ac0-a0fe-a4d67bdde305"
  use_cli = true
  resource_provider_registrations = "none"
}

resource "random_string" "suffix" {
  length  = 8
  special = false # not include special characters
  upper   = false # not include uppercase characters
  numeric = true  # not Include numeric characters in the string
}

# Data Sources
data "azurerm_client_config" "current" {}



module "resource_group" {
  source   = "./modules/resource_group"
  name     = var.resource_group_name
  location = var.location
}

# Declare the resource group in the root module
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = "vnet-${random_string.suffix.result}"
  address_space       = ["10.0.0.0/16"]
  subnet_name         = "subnet-${random_string.suffix.result}"
  subnet_prefixes     = ["10.0.1.0/24"]
  public_ip_name      = "public-ip"
  public_ip_sku       = "Standard"
  nic_name            = "nic-${random_string.suffix.result}"
  location            = var.location
}
# VM Module
module "vm" {
  source              = "./modules/vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  vm_size             = var.vm_size
  ssh_public_key_path = var.ssh_public_key_path
  ssh_private_key_path = var.ssh_private_key_path
  network_interface_id = module.network.nic_id  # Ensure this output exists
  network_public_ip   = module.network.public_ip_address  # Pass the public IP here
  os_disk_size         = var.os_disk_size
  subnet_id           = module.network.subnet_id
  
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = "acr-${random_string.suffix.result}"
  # admin_enabled       = false
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

module "keyvault" {
  source              = "./modules/keyvault"
  keyvault_name       = "kv-${random_string.suffix.result}"
  resource_group_name = module.network.resource_group_name
  location            = var.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

module "aks" {
  source              = "./modules/aks"
  cluster_name        = "aks-${random_string.suffix.result}"
  dns_prefix          = "dns-${random_string.suffix.result}"
  node_count          = 1
  vm_size             = "Standard_D4s_v3"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

resource "null_resource" "update_inventory_and_run_playbook" {
  depends_on = [module.network]  # ensure network resources are created first

  # First provisioner: Update the Ansible inventory file with the new Jenkins server IP and credentials
  provisioner "local-exec" {
    command = <<EOT
      echo "Updating inventory file with Jenkins server IP..."
      echo "[jenkins_server]" > ${path.module}/../ansible/inventory.ini
      echo "${module.vm.vm_public_ip} ansible_user=azureuser ansible_ssh_private_key_file=${var.ssh_private_key_path} ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'" >> ${path.module}/../ansible/inventory.ini
      cat ${path.module}/../ansible/inventory.ini  # Debugging output
    EOT
  }

  # Second provisioner: Run the Ansible playbook to install Jenkins
  provisioner "local-exec" {
    command = <<EOT
      IP_ADDRESS="${module.vm.vm_public_ip}"
      max_retries=5
      attempt=1
      
      # Wait for Jenkins server to be ready by checking SSH connectivity
      while [ $attempt -le $max_retries ]; do
        # Attempt to connect via SSH
        if ssh -o StrictHostKeyChecking=no -i ${var.ssh_private_key_path} azureuser@$IP_ADDRESS exit; then
          echo "SSH connection successful."
          break
        else
          echo "Attempt $attempt failed, retrying in 10 seconds..."
          ((attempt++))
          sleep 10
        fi
      done

      if [ $attempt -gt $max_retries ]; then
        echo "Failed to establish SSH connection after $max_retries attempts."
        exit 1
      fi

      # If SSH is successful, run the Ansible playbook
      ansible-playbook -vvvv -i ${path.module}/../ansible/inventory.ini ${path.module}/../ansible/playbook.yml
    EOT
  }
}