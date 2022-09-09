param vmName string
param vmImageReference array = [
  'Canonical'
  'UbuntuServer'
  '18.04-LTS'
  'latest'
]
param vmPricingTier string
param diskPricingTier string
param location string = resourceGroup().location

@description('vnet name')
param vnet string

@description('subnet name')
param subnet string

@description('admin username')
param username string

@description('admin password')
param pass string

resource vmName_resource 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  name: vmName
  location: location
  identity: {
    type: 'None'
  }
  properties: {
    additionalCapabilities: {
      ultraSSDEnabled: false
    }
    hardwareProfile: {
      vmSize: vmPricingTier
    }
    osProfile: {
      computerName: vmName
      adminPassword: pass
      adminUsername: username
      allowExtensionOperations: true
    }
    storageProfile: {
      imageReference: {
        publisher: vmImageReference[0]
        offer: vmImageReference[1]
        sku: vmImageReference[2]
        version: vmImageReference[3]
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: diskPricingTier
        }
        name: '${vmName}disk'
      }
    }
    networkProfile: {
      networkApiVersion: '2020-11-01'
      networkInterfaceConfigurations: [
        {
          name: '${vmName}NIC'
          properties: {
            deleteOption: 'Delete'
            ipConfigurations: [
              {
                name: '${vmName}publicIP'
                properties: {
                  publicIPAddressConfiguration: {
                    name: '${vmName}publicIP'
                    properties: {
                      deleteOption: 'Delete'
                      publicIPAddressVersion: 'IPv4'
                      publicIPAllocationMethod: 'Static'
                    }
                  }
                  subnet: {
                    id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet, subnet)
                  }
                }
              }
            ]
          }
        }
      ]
    }
  }
}
