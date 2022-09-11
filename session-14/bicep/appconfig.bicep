@description('Specifies the name of the App Configuration store.')
param configName string
param location string = resourceGroup().location

@description('Specifies the names of the key-value resources. The name is a combination of key and label with $ as delimiter. The label is optional.')
param keyValueNames array = [
  'myKey'
  'myKey$myLabel'
]

resource configName_resource 'Microsoft.AppConfiguration/configurationStores@2021-10-01-preview' = {
  name: configName
  location: location
  sku: {
    name: 'standard'
  }
}

resource configName_keyValueNames 'Microsoft.AppConfiguration/configurationStores/keyValues@2021-10-01-preview' = [for item in keyValueNames: {
  name: '${configName}/${item}'
  properties: {
  }
  dependsOn: [
    configName_resource
  ]
}]