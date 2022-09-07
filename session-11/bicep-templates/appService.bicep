param serviceName string
param appName string
param region string
param pricingTier string
param nodes int
param dockerImage string

resource serviceName_resource 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: serviceName
  location: region
  kind: 'linux'
  sku: {
    name: pricingTier
  }
  tags: {
    displayName: serviceName
  }
  properties: {
    targetWorkerCount: nodes
    reserved: true
  }
}

resource appName_resource 'Microsoft.Web/sites@2020-12-01' = {
  name: appName
  location: region
  kind: 'app,linux,container'
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/${serviceName}': 'Resource'
    displayName: appName
  }
  properties: {
    serverFarmId: serviceName_resource.id
    siteConfig: {
      numberOfWorkers: nodes
      linuxFxVersion: 'DOCKER|${dockerImage}'
    }
  }
}
