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
variable "nsgName" {
  type = string
}
variable "vName" {
  type = string
}
variable "subnet" {
  type = string
  default = "tf-subnet1"
}

data "azurerm_resource_group" "testingARM" {
    name = var.rg
}
data "azurerm_subnet" "subnet" {
  name                 = var.subnet
  virtual_network_name = var.vName
  resource_group_name  = var.rg
}
data "azurerm_network_security_group" "nsg" {
  name                = var.nsgName
  resource_group_name = var.rg
}

resource "azurerm_subnet_network_security_group_association" "assign" {
  subnet_id                 = data.azurerm_subnet.subnet.id
  network_security_group_id = data.azurerm_network_security_group.nsg.id
}