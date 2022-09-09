param region string
param vnetParams object = {
  vnet: {
    name: 'Example-vnet'
    addressPrefix: '10.0.0.0/16'
  }
  subnets: [
    {
      addressPrefix: '10.0.1.0/24'
      name: 'Example-vnet-subnet1'
    }
    {
      addressPrefix: '10.0.2.0/24'
      name: 'Example-vnet-subnet2'
    }
  ]
}

resource vnetParams_vnet_name 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: vnetParams.vnet.name
  location: region
  tags: {
    displayName: vnetParams.vnet.name
  }
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetParams.vnet.addressPrefix
      ]
    }
    subnets: [for j in range(0, length(vnetParams.subnets)): {
      name: vnetParams.subnets[j].name
      properties: {
        addressPrefix: vnetParams.subnets[j].addressPrefix
      }
    }]
  }
}