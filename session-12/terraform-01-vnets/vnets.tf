terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.0.2"
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
variable "vName" {
  type = string
}
variable "vAddress" {
  type = string
}
variable "subnets" {
  type = list
  default = [
        {
            name = "tf-subnet1"
            address_prefix = "10.0.1.0/24"
        },
        {
            name = "tf-subnet2"
            address_prefix = "10.0.2.0/24"
        }
    ]
}

data "azurerm_resource_group" "testingARM" {
    name = var.rg
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vName
  location            = var.location
  resource_group_name = var.rg
  address_space       = [var.vAddress]
}

resource "azurerm_subnet" "subnet" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  address_prefixes     = [var.subnets[count.index].address_prefix]
  resource_group_name  = var.rg
  virtual_network_name = azurerm_virtual_network.vnet.name
}