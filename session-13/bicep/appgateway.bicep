param location string

@description('application gateway name')
param gatName string

@description('array of objects of endpoints')
param endpoints array

@description('array of web application firewall rules')
param wafRules array = [
  'OWASP'
  '3.2'
]

@description('name of waf')
param wafName string

param appName string

@description('name of virtual network')
param vName string

@description('name of public ip address')
param ipName string

@description('subnet name')
param subnet string

@description('Address prefix for app gateway subnet')
param addressPrefix string

resource vName_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  name: '${vName}/${subnet}'
  properties: {
    addressPrefix: addressPrefix
  }
}

resource ipName_resource 'Microsoft.Network/publicIPAddresses@2020-08-01' = {
  name: ipName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource wafName_resource 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2020-11-01' = {
  name: wafName
  location: location
  properties: {
    policySettings: {
      requestBodyCheck: true
      maxRequestBodySizeInKb: 128
      fileUploadLimitInMb: 100
      state: 'Enabled'
      mode: 'Detection'
    }
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: wafRules[0]
          ruleSetVersion: wafRules[1]
        }
      ]
    }
  }
  dependsOn: []
}

resource gatName_resource 'Microsoft.Network/applicationGateways@2020-11-01' = {
  name: gatName
  location: location
  properties: {
    sku: {
      name: 'WAF_v2'
      tier: 'WAF_v2'
      capacity: 2
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: vName_subnet.id
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGatewayFrontendIP'
        properties: {
          privateIPAllocationMethod: 'Dynamic'

          publicIPAddress: {
            id: ipName_resource.id
          }
        }
      }
    ]
    frontendPorts: [for item in endpoints: {
      name: item.name
      properties: {
        port: item.Port
      }
    }]
    backendAddressPools: [
      {
        name: 'appGatewayBackendPool'
        properties: {
          backendAddresses: [
            {
                fqdn: '${appName}.azurewebsites.net'
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', gatName, 'appGatewayFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', gatName, endpoints[0].name)
          }
          protocol: 'Http'
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'ruleName'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', gatName, 'appGatewayHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', gatName, 'appGatewayBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', gatName, 'appGatewayBackendHttpSettings')
          }
        }
      }
    ]
    firewallPolicy: {
      id: wafName_resource.id
    }
  }
}
