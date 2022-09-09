param region string
param nsgName string
param rules array = [
  'AllowAll'
  'AllowAllOutbound'
  'Tcp'
  '*'
  '*'
  '*'
  '*'
  'Allow'
  100
  'Outbound'
]

@description('The name of the existing VNet')
param virtualNetworkName string

@description('Name and address prefix of a subnet for nsg assignment')
param subnet array = [
  'arm-subnet1'
  '10.0.1.0/24'
]

resource nsgName_resource 'Microsoft.Network/networkSecurityGroups@2020-11-01' = {
  name: nsgName
  location: region
  properties: {
    securityRules: [
      {
        name: rules[0]
        properties: {
          description: rules[1]
          protocol: rules[2]
          sourcePortRange: rules[3]
          destinationPortRange: rules[4]
          sourceAddressPrefix: rules[5]
          destinationAddressPrefix: rules[6]
          access: rules[7]
          priority: rules[8]
          direction: rules[9]
        }
      }
    ]
  }
}

resource virtualNetworkName_subnet_0 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  name: '${virtualNetworkName}/${subnet[0]}'
  location: region
  properties: {
    addressPrefix: subnet[1]
    networkSecurityGroup: {
      id: nsgName_resource.id
    }
  }
}
