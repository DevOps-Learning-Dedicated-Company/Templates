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
variable "serviceName" {
  type = string
}

data "azurerm_service_plan" "plan" {
  name                = var.serviceName
  resource_group_name = var.rg
}


resource "azurerm_linux_web_app" "app" {
  name                = var.appName
  resource_group_name = var.rg
  location            = var.location
  service_plan_id     = data.azurerm_service_plan.plan.id
  identity {
    type = "SystemAssigned"
  }
  site_config {}
}

# template ran with this command:
# terraform import azurerm_linux_web_app.app /subscriptions/26b3c258-f71f-4c14-b08e-32bff9b16b5a/resourceGroups/testingARM/providers/Microsoft.Web/sites/tflinuxapp