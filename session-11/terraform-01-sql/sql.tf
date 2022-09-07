terraform {
  #required_version = ">= 0.12"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.0.2"
    }
  }
}

 provider "azurerm" {
   features {
     
   }
 }

variable "rg" {
  type = string
}
variable "location" {
  type = string
}
variable "serverName" {
  type = string
}
variable "dbName" {
  type = string
}
variable "dbPricingTier" {
  type = string
}
variable "dbBackupPolicy" {
  type = string
}
variable "rules" {
  type = list
}

data "azurerm_resource_group" "testingARM" {
    name = var.rg
}

resource "azurerm_mssql_server" "tfsqlserver01" {
  name                         = var.serverName
  resource_group_name          = var.rg
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "adminadmin"
  administrator_login_password = "Thisismysqlpassword1!"
}

resource "azurerm_mssql_firewall_rule" "firewall" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.tfsqlserver01.id
  start_ip_address = var.rules[0]
  end_ip_address   = var.rules[1]
}

resource "azurerm_mssql_database" "db" {
  name           = var.dbName
  server_id      = azurerm_mssql_server.tfsqlserver01.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = var.dbPricingTier
  storage_account_type = var.dbBackupPolicy
}