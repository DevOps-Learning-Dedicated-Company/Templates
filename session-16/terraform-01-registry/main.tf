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

variable "acrName" {
  type = string
}
variable "location" {
  type = string
}
variable "rg" {
  type = string
}


resource "azurerm_container_registry" "acr" {
  name                = var.acrName
  resource_group_name = var.rg
  location            = var.location
  sku                 = "Basic"

}