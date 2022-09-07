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
variable "storageName" {
  type = string
}
variable "accTier" {
  type = string
}
variable "accType" {
  type = string
}

data "azurerm_resource_group" "testingARM" {
    name = var.rg
}

resource "azurerm_storage_account" "st" {
  name                     = var.storageName
  resource_group_name      = var.rg
  location                 = var.location
  account_tier             = var.accTier
  account_replication_type = var.accType
}

resource "azurerm_storage_container" "container" {
  name                  = "backupcontainer"
  storage_account_name  = azurerm_storage_account.st.name
  container_access_type = "blob"
}

output "sastoken" {
  value = azurerm_storage_account.st.primary_connection_string
}