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
variable "dbName" {
  type = string
}
variable "planName" {
  type = string
}
variable "serverName" {
  type = string
}
variable "pass" {
  type = string
}

data "azurerm_service_plan" "plan" {
  name                = var.planName
  resource_group_name = var.rg
}
data "azurerm_mssql_server" "server" {
  name                 = var.serverName
  resource_group_name  = var.rg
}
data "azurerm_mssql_database" "db" {
  name                 = var.dbName
  server_id            = data.azurerm_mssql_server.server.id
}


resource "azurerm_linux_web_app" "linuxwebapp" {
  name                = var.appName
  resource_group_name = var.rg
  location            = var.location
  service_plan_id     = data.azurerm_service_plan.plan.id

  site_config {
  }

  connection_string {
    name  = "conStr"
    value = "Server=tcp:${data.azurerm_mssql_server.server.fully_qualified_domain_name},1433;Initial Catalog=${data.azurerm_mssql_database.db.name};Persist Security Info=False;User ID=${data.azurerm_mssql_server.server.administrator_login};Password=${var.pass};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    type = "SQLAzure"
  }
}

# var.pass to be changed to a secret
# script ran with command:
# terraform import azurerm_linux_web_app.linuxwebapp /subscriptions/26b3c258-f71f-4c14-b08e-32bff9b16b5a/resourceGroups/testingARM/providers/Microsoft.Web/sites/tflinuxapp