terraform {
    required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
    azapi = {
      source = "azure/azapi"
    }
  }
}

provider "azurerm" {
  features {}
}
provider "azapi" {
}

variable "sName" {
  type = string
}
variable "rg" {
  type = string
}
variable "location" {
  type = string
}
variable "sku" {
  type = map(any)
}
variable "iName" {
  type = string
}
variable "scriptUri" {
  type = string
  default = "https://raw.githubusercontent.com/DevOps-Learning-Dedicated-Company/Templates/main/session-16/script.sh"
}

data "azurerm_resource_group" "rg" {
  name = var.rg
}


resource "azurerm_storage_account" "storage" {
  name                     = var.sName
  resource_group_name      = var.rg
  location                 = var.location
  account_tier             = var.sku.tier
  account_replication_type = var.sku.type
  account_kind             = "StorageV2"
}

resource "azurerm_user_assigned_identity" "identity" {
  resource_group_name = var.rg
  location            = var.location
  name = var.iName
}

resource "random_id" "tag" {
  byte_length = 4
}

resource "azapi_resource" "script" {
  type      = "Microsoft.Resources/deploymentScripts@2020-10-01"
  name      = "tfscriptforstaticweb"
  location  = var.location
  parent_id = data.azurerm_resource_group.rg.id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.identity.id]
  }

  body = jsonencode({
    name = "tfscriptforstaticweb"
    kind = "AzureCLI"
    properties = {
      arguments            = "--name ${var.sName} --index index.html --error 404.html"
      azCliVersion         = "2.9.0"
      cleanupPreference    = "Always"
      forceUpdateTag       = "tag${random_id.tag.hex}"
      scriptContent        = "az storage blob service-properties update --account-key ${azurerm_storage_account.storage.primary_access_key} --account-name ${var.sName} --static-website --404-document 404.html --index-document index.html --verbose -o table"
      retentionInterval    = "P1D"
      supportingScriptUris = []
      timeout              = "PT10M"
    }
  })
}

# resource "azapi_resource" "symbolicname" {
#   type = "Microsoft.Resources/deploymentScripts@2020-10-01"
#   name = "string"
#   location = "string"
#   parent_id = "string"
#   tags = {
#     tagName1 = "tagValue1"
#     tagName2 = "tagValue2"
#   }
#   identity {
#     type = "UserAssigned"
#     identity_ids = []
#   }
#   // For remaining properties, see deploymentScripts objects
#   body = jsonencode({
#     kind = "string"
#   })
# }