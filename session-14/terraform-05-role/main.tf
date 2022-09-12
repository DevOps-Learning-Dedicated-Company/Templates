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
variable "confName" {
  type = string
}
variable "appName" {
  type = string
}

data "azurerm_app_configuration" "conf" {
  name                = var.confName
  resource_group_name = var.rg
}
data "azurerm_linux_web_app" "app" {
  name                = var.appName
  resource_group_name = var.rg
}


resource "azurerm_role_assignment" "role" {
  scope                = data.azurerm_app_configuration.conf.id
  role_definition_name = "App Configuration Data Reader"
  principal_id         = data.azurerm_linux_web_app.app.identity.0.principal_id
}