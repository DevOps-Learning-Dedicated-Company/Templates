terraform {
    required_version = ">= 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  backend "azurerm" {
        resource_group_name  = "testing"
        storage_account_name = "tfstatesacc"
        container_name       = "tfstates"
        key                  = "terraform.tfstate"
    }
}

provider "azurerm" {
  features {}
}

variable "rg" {
  type = string
  default = "testing"
}


data "azurerm_resource_group" "rg" {
  name = var.rg
}
