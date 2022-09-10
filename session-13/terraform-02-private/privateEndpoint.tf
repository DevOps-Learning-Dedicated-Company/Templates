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
variable "appName" {
  type = string
}
variable "sName" {
  type = string
}
variable "vName" {
  type = string
}

data "azurerm_linux_web_app" "webapp" {
  name                = var.appName
  resource_group_name = var.rg
}
data "azurerm_subnet" "subnet" {
  name                 = var.sName
  virtual_network_name = var.vName
  resource_group_name  = var.rg
}

resource "azurerm_private_endpoint" "pe" {
  name                = "privEnd01"
  location            = var.location
  resource_group_name = var.rg
  subnet_id           = data.azurerm_subnet.subnet.id


  private_service_connection {
    name                           = "peconnection"
    private_connection_resource_id = data.azurerm_linux_web_app.webapp.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}