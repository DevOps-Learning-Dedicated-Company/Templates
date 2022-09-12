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

variable "keyVaultName" {
  type = string
}
variable "rg" {
  type = string
}
variable "appName" {
  type = string
}

data "azurerm_client_config" "current" {}
data "azurerm_key_vault" "vault" {
  name                = var.keyVaultName
  resource_group_name = var.rg
}
data "azurerm_linux_web_app" "app" {
  name                = var.appName
  resource_group_name = var.rg
}


resource "azurerm_key_vault_access_policy" "myapp" {
  key_vault_id = data.azurerm_key_vault.vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_linux_web_app.app.identity.0.principal_id

  secret_permissions = [
    "Get", "List"
  ]
}