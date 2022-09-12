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
variable "storageName" {
  type = string
}
variable "appName" {
  type = string
}
variable "freInt" {
  type = string
}
variable "freUnit" {
  type = string
}
variable "image" {
  type = string
  default = "mcr.microsoft.com/dotnet/samples:aspnetapp"
}

data "azurerm_resource_group" "testingARM" {
  name = var.rg
}
data "azurerm_service_plan" "plan" {
  name                = var.serviceName
  resource_group_name = var.rg
}
data "azurerm_storage_account" "st" {
  name                = var.storageName
  resource_group_name = var.rg
}
data "azurerm_storage_account_sas" "sastoken" {
  connection_string = data.azurerm_storage_account.st.primary_connection_string
  https_only        = true
  signed_version    = timeadd(timestamp(), "168h")

  resource_types {
    service   = true
    container = true
    object    = false
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timeadd(timestamp(), "5m")
  expiry = "2023-01-01T00:00:00Z"

  permissions {
    read    = true
    write   = true
    delete  = false
    list    = false
    add     = true
    create  = true
    update  = false
    process = false
    tag     = false
    filter  = false
  }
}



resource "azurerm_linux_web_app" "app" {
  name                = var.appName
  resource_group_name = var.rg
  location            = var.location
  service_plan_id     = data.azurerm_service_plan.plan.id
  backup {
    name = "backup123"
    schedule {
        frequency_interval = var.freInt
        frequency_unit = var.freUnit
    }
    storage_account_url = "https://${var.storageName}.blob.core.windows.net/backupcontainer?${data.azurerm_storage_account_sas.sastoken.sas}"
  }

  site_config {
    application_stack {
      docker_image = var.image
      docker_image_tag = "latest"
    }
  }
}