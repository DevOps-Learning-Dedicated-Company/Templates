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
variable "kName" {
  type = string
}

data "azurerm_client_config" "current" {}


resource "azurerm_key_vault" "kv" {
  name                        = var.kName
  location                    = var.location
  resource_group_name         = var.rg
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.client_id

    key_permissions = [
      "Get", "List",
    ]

    secret_permissions = [
      "Get", "List"
    ]
  }
}