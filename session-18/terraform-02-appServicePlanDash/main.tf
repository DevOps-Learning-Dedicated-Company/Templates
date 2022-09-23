terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

variable "appServicePlanName" {
  type = string
}
variable "rg" {
  type = string
}
variable "location" {
  type = string
}
variable "dashboardName" {
  type = string
}

data "azurerm_resource_group" "rg" {
  name = var.rg
}
data "azurerm_service_plan" "plan" {
  name = var.appServicePlanName
  resource_group_name = var.rg
}


resource "azurerm_portal_dashboard" "my-board" {
  name                = var.dashboardName
  resource_group_name = var.rg
  location            = var.location
  tags = {
    source = "terraform"
  }
  dashboard_properties = templatefile("dash.tpl",
    {
      id     = data.azurerm_service_plan.plan.id
      appServicePlanName = var.appServicePlanName
  })
}