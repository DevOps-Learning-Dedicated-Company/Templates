@description('The location in which all resources should be deployed.')
param location string = resourceGroup().location

@description('The name of the app to create.')
param appName string = uniqueString(resourceGroup().id)

var appServicePlanName_var = '${appName}${uniqueString(subscription().subscriptionId)}'
var vnetName_var = '${appName}vnet'
var vnetAddressPrefix = '10.0.0.0/16'
var subnetName = '${appName}sn'
var subnetAddressPrefix = '10.0.0.0/24'
var appServicePlanSku = 'S1'

resource appServicePlanName 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName_var
  location: location
  sku: {
    name: appServicePlanSku
  }
  kind: 'app'
}

resource vnetName 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetName_var
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
          delegations: [
            {
              name: 'delegation'
              properties: {
                serviceName: 'Microsoft.Web/serverFarms'
              }
            }
          ]
        }
      }
    ]
  }
}

resource appName_resource 'Microsoft.Web/sites@2021-01-01' = {
  name: appName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlanName.id
    virtualNetworkSubnetId: vnetName.properties.subnets[0].id
    httpsOnly: true
    siteConfig: {
      vnetRouteAllEnabled: true
      http20Enabled: true
    }
  }
}