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

variable "iName" {
  type = string
}
variable "rg" {
  type = string
}
variable "location" {
  type = string
}
variable "type" {
  type = string
}
variable "requestSource" {
  type = string
  default = "CustomDeployment"
}
variable "tName" {
  type = string
}
variable "testKind" {
  type = string
  default = "standard"
}
variable "httpverb" {
  type = string
  default = "GET"
}
variable "url" {
  type = string
  default = "https://google.com"
}
variable "responseCode" {
  type = number
  default = 200
}


data "azurerm_resource_group" "rg" {
  name = var.rg
}


resource "azapi_resource" "insight" {
  type = "Microsoft.Insights/components@2020-02-02"
  name = var.iName
  location = var.location
  parent_id = data.azurerm_resource_group.rg.id
  body = jsonencode({
    properties = {
      Application_Type = var.type
      Flow_Type = "Bluefield"
      ImmediatePurgeDataOn30Days = true
      Request_Source = var.requestSource
      RetentionInDays = 30
    }
    kind = var.type
  })
}

resource "azapi_resource" "webtest" {
  type = "Microsoft.Insights/webtests@2022-06-15"
  name = var.tName
  location = var.location
  parent_id = data.azurerm_resource_group.rg.id
  tags = {
    "hidden-link:${azapi_resource.insight.id}" = "Resource"
  }
  body = jsonencode({
    properties = {
      Enabled = true
      Frequency = 7
      Kind = var.testKind
      Locations = [
        {
          Id = "emea-se-sto-edge"
        }
      ]
      Name = var.tName
      SyntheticMonitorId = var.tName
      Request = {
        FollowRedirects = true
        HttpVerb = var.httpverb
        RequestUrl = var.url
      }
      RetryEnabled = true
      ValidationRules = {
        ExpectedHttpStatusCode = var.responseCode
        SSLCertRemainingLifetimeCheck = 7
        SSLCheck = true
      }
    }
    kind = var.testKind
  })
}

