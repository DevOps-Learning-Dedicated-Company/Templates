terraform {
    required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
}
provider "azurerm" {
  features {}
}


variable "rg" {
  type = string
}
variable "location" {
  type = string
}
variable "subnetName" {
  type = string
}
variable "vName" {
  type = string
}
variable "vmSize" {
  type = string
}
variable "diskPricingTier" {
  type = string
}
variable "vmName" {
  type = string
}
variable "vmImage" {
  type = map(any)
}

data "azurerm_subnet" "subnet" {
  name                 = var.subnetName
  virtual_network_name = var.vName
  resource_group_name  = var.rg
}


resource "azurerm_public_ip" "publicIP" {
  name                = "${var.vmName}PublicIP"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
}

# resource "tls_private_key" "example_ssh" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

resource "azurerm_network_interface" "nic" {
  name                = "${var.vmName}NIC"
  location            = var.location
  resource_group_name = var.rg

  ip_configuration {
    name                          = "nicConfiguration"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicIP.id
  }
}

resource "azurerm_linux_virtual_machine" "linuxVm" {
  name                  = var.vmName
  location              = var.location
  resource_group_name   = var.rg
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = var.vmSize

  os_disk {
    name                 = "OsDisk"
    caching              = "ReadWrite"
    storage_account_type = var.diskPricingTier
  }

  source_image_reference {
    publisher = var.vmImage.publisher
    offer     = var.vmImage.offer
    sku       = var.vmImage.sku
    version   = var.vmImage.version
  }

  computer_name                   = var.vmName
  admin_username                  = "azureuser"
  admin_password                  = "Thisismyvmpassword1" #to be replaced with a real password hidden behind a secret
  disable_password_authentication = false

#   admin_ssh_key {
#     username   = "azureuser"
#     public_key = tls_private_key.example_ssh.public_key_openssh
#   }
}