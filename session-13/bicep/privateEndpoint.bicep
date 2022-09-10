param sName string
param vName string
param appName string

@description('address prefix for a subnet')
param addressPrefix string

var subnetid = vName_sName.id
var webapp = resourceId('Microsoft.Web/sites', appName)

resource vName_sName 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  name: '${vName}/${sName}'
  properties: {
    addressPrefix: addressPrefix
  }
}

resource armPrivateEndpoint 'Microsoft.Network/privateEndpoints@2020-11-01' = {
  name: 'armPrivateEndpoint'
  location: resourceGroup().location
  properties: {
    subnet: {
      id: subnetid
    }
    privateLinkServiceConnections: [
      {
        name: 'armPrivateEndpoint'
        properties: {
          privateLinkServiceId: webapp
          groupIds: [
            'sites'
          ]
        }
      }
    ]
  }
}