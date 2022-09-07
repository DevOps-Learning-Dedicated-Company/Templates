param storageName string
param region string
param skuName string


resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageName
  sku: {
    name: skuName
  }
  kind: 'StorageV2'
  location: region
}
