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
variable "gatName" {
  type = string
}
variable "networkData" {
  type = map
  default = {
    sName = "tf-subnet3"
    vName = "tf-vnet"
  }
}
variable "wafRules" {
  type = list
  default = ["OWASP", "3.2"]
}
variable "frontend_endpoints" {
  type = list
}

data "azurerm_subnet" "subnet" {
  name                 = var.networkData.sName
  virtual_network_name = var.networkData.vName
  resource_group_name  = var.rg
}



resource "azurerm_public_ip" "publicIP" {
  name                = "${var.gatName}PublicIP"
  location            = var.location
  resource_group_name = var.rg
  allocation_method   = "Static"
  sku = "Standard"
}

resource "azurerm_web_application_firewall_policy" "waf" {
  name                = "tf-waf"
  resource_group_name = var.rg
  location            = var.location

  policy_settings {
    enabled                     = true
    mode                        = "Detection"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {
    managed_rule_set {
      type    = var.wafRules[0]
      version = var.wafRules[1]
    }
  }
}

resource "azurerm_application_gateway" "gateway" {
  name                = var.gatName
  resource_group_name = var.rg
  location            = var.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = data.azurerm_subnet.subnet.id
  }

  dynamic "frontend_port" {
    for_each = toset(var.frontend_endpoints)
    content {
      name = lookup(frontend_port.value, "name", null)
      port = lookup(frontend_port.value, "port", null)
    }
  }

  backend_address_pool {
    name = "pool01"
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIP"
    public_ip_address_id = azurerm_public_ip.publicIP.id
  }

  backend_http_settings {
    name                  = "backend-setting01"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

   http_listener {
    name                           = "httpListener01"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "port_80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule01"
    rule_type                  = "Basic"
    http_listener_name         = "httpListener01"
    backend_address_pool_name  = "pool01"
    backend_http_settings_name = "backend-setting01"
  }

  firewall_policy_id = azurerm_web_application_firewall_policy.waf.id
}