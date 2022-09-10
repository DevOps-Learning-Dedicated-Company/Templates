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


variable "vName" {
  type = string
}
variable "location" {
  type = string
}
variable "rg" {
  type = string
}
variable "sName" {
  type = string
}
variable "appName" {
  type = string
}
variable "addressPrefix" {
  type = string
  default = "10.0.0.0/24"
}

data "azurerm_virtual_network" "vnet" {
  name = var.vName
  resource_group_name = var.rg
}
data "azurerm_linux_web_app" "webapp" {
  name                = var.appName
  resource_group_name = var.rg
}


resource "azurerm_subnet" "subnet" {
  name                 = var.sName
  resource_group_name  = var.rg
  virtual_network_name = var.vName
  address_prefixes     = [var.addressPrefix]
  delegation {
    name = "delegation"
    service_delegation {
      name = "Microsoft.Web/serverFarms"
    }
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "integration" {
  app_service_id = data.azurerm_linux_web_app.webapp.id
  subnet_id      = azurerm_subnet.subnet.id
}