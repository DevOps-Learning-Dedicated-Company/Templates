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

variable "confName" {
  type = string
}
variable "rg" {
  type = string
}
variable "location" {
  type = string
}
variable "sku" {
  type = string
}


resource "azurerm_app_configuration" "appconf" {
  name                = var.confName
  resource_group_name = var.rg
  location            = var.location
  sku                 = var.sku
}