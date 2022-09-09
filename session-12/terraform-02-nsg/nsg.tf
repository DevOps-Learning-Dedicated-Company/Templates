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
variable "nsgName" {
  type = string
}
variable "rules" {
  type = list
  default = [
    {
        name                        = "test123"
        priority                    = 100
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "*"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }
  ]
}

data "azurerm_resource_group" "testingARM" {
    name = var.rg
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsgName
  location            = var.location
  resource_group_name = var.rg
}

resource "azurerm_network_security_rule" "rules" {
  count                       = length(var.rules)
  name                        = var.rules[count.index].name
  priority                    = var.rules[count.index].priority
  direction                   = var.rules[count.index].direction
  access                      = var.rules[count.index].access
  protocol                    = var.rules[count.index].protocol
  source_port_range           = var.rules[count.index].source_port_range
  destination_port_range      = var.rules[count.index].destination_port_range
  source_address_prefix       = var.rules[count.index].source_address_prefix
  destination_address_prefix  = var.rules[count.index].destination_address_prefix
  resource_group_name         = var.rg
  network_security_group_name = azurerm_network_security_group.nsg.name
}