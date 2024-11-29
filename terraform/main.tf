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
  node_count          = 2
  vm_size             = "Standard_D4s_v3"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}


# resource "null_resource" "update_inventory_and_run_playbook" {
#   depends_on = [module.network] # Ensure the network module has completed

#   # Generate inventory file with the public IP of the VM
#   provisioner "local-exec" {
#     command = <<EOT
#       # Set the path to the inventory file relative to your directory structure
#       echo "[jenkins_server]" > ${path.module}/../ansible/inventory.ini
#       echo "${module.vm.vm_public_ip} ansible_user=azureuser ansible_ssh_private_key_file=${var.ssh_private_key_path}" >> ${path.module}/../ansible/inventory.ini
#     EOT
#   }

#   # Run Ansible playbook to install Jenkins
#   provisioner "local-exec" {
#     command = <<EOT
#       ansible-playbook -i ${path.module}/../ansible/inventory.ini ${path.module}/../ansible/playbook.yml
#     EOT
#   }
# }

resource "null_resource" "update_inventory_and_run_playbook" {
  depends_on = [module.network] # Ensure the network module has completed

  # Generate inventory file with the public IP of the VM
  provisioner "local-exec" {
    command = <<EOT
      echo "[jenkins_server]" > /Users/noble/newclonecicd/cicd_terraform_project/ansible/inventory.ini
      echo "${module.vm.vm_public_ip} ansible_user=azureuser ansible_ssh_private_key_file=${var.ssh_private_key_path}" >> /Users/noble/newclonecicd/cicd_terraform_project/ansible/inventory.ini
    EOT
  }

  # Run Ansible playbook to install Jenkins
  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook -i /Users/noble/newclonecicd/cicd_terraform_project/ansible/inventory.ini /Users/noble/newclonecicd/cicd_terraform_project/ansible/playbook.yml -vvvv
    EOT
  }
}
