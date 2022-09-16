@description('Container registry name')
param rName string
param location string

resource rName_resource 'Microsoft.ContainerRegistry/registries@2021-12-01-preview' = {
  name: rName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}