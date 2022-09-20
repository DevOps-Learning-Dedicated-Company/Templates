@metadata({ desctription: 'Storage name' })
param sName string
param location string = resourceGroup().location
param sku string
param unique_id string = utcNow()

@description('User Assigned Managed identity name')
param iName string

var site = {
  index: 'index.html'
  error: '404.html'
}
var staticWebsite = {
  arguments: '--name ${sName} --index ${site.index} --error ${site.error}'
}

resource sName_resource 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: sName
  location: location
  sku: {
    name: sku
  }
  kind: 'StorageV2'
}

resource iName_resource 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: iName
  location: location
}

resource staticWebsiteScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'staticWebsiteScript'
  location: location
  kind: 'AzureCLI'
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${iName_resource.id}': {
      }
    }
  }
  properties: {
    forceUpdateTag: unique_id
    azCliVersion: '2.9.1'
    arguments: staticWebsite.arguments
    scriptContent: 'az storage blob service-properties update --account-key wWfTA611nbMUPYLoNFSng++aBpB279bv78qE8+zu20YTDyq+n/MP153kBtdrdW3+rI+3BVx/e/Rg+AStPU18NA== --account-name armconforstaticweb --static-website --404-document 404.html --index-document index.html --verbose -o table'
    supportingScriptUris: []
    timeout: 'PT10M'
    cleanupPreference: 'Always'
    retentionInterval: 'P1D'
  }
  dependsOn: [
    sName_resource

  ]
}

output website_url string = reference(sName_resource.id, '2021-06-01', 'Full').properties.primaryEndpoints.web