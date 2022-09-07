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
variable "serviceName" {
  type = string
}
variable "appName" {
  type = string
}
variable "pricingTier" {
  type = string
}
variable "nodes" {
  type = string
}
variable "image" {
  type = string
}

data "azurerm_resource_group" "testingARM" {
    name = var.rg
}

resource "azurerm_service_plan" "plan" {
  name                = var.serviceName
  resource_group_name = var.rg
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.pricingTier
  worker_count        = var.nodes
}

resource "azurerm_linux_web_app" "app" {
  name                = var.appName
  resource_group_name = var.rg
  location            = var.location
  service_plan_id     = azurerm_service_plan.plan.id
  

  site_config {
    application_stack {
      docker_image = var.image
      docker_image_tag = "linuxwebapp"
    }
  }
}

output "id" {
  value = azurerm_service_plan.plan.id
}

output "image" {
  value = azurerm_linux_web_app.app.site_config[0]
}

output "imagetag" {
  value = azurerm_linux_web_app.app.site_config[1]
}