param appName string
param storageName string
param frequencyInterval int
param frequencyUnit string
param retention int
param startTime string = dateTimeAdd(utcNow(), 'PT5M')
param signedExpiry string = dateTimeAdd(utcNow(), 'P1Y')
param dbType string
param dbName string
param serverName string
param serverPass string

var sasConfig = {
  canonicalizedResource: '/blob/${storageName}/backup1234'
  signedResourceTypes: 'sco'
  signedPermission: 'r'
  signedServices: 'b'
  signedExpiry: signedExpiry
  signedProtocol: 'https'
  keyToSign: 'key2'
}

var sasToken = storage.listServiceSAS(storage.apiVersion, sasConfig).serviceSasToken

var containerEndpoint = storage.properties.primaryEndpoints.blob


resource appName_resource 'Microsoft.Web/sites@2020-12-01' existing = {
  name: appName
}

resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' existing = {
  name: storageName
}

resource server 'Microsoft.Sql/servers@2021-11-01-preview' existing = {
  name: serverName
}

resource blobservice 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  name: 'default'
  parent: storage
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: 'backupcontainer2137'
  parent: blobservice
}

resource backup 'Microsoft.Web/sites/config@2022-03-01' = {
  name: 'backup'
  kind: 'app, linux, container'
  parent: appName_resource
  properties: {
    backupName: 'backup1234'
    backupSchedule: {
      frequencyInterval: frequencyInterval
      frequencyUnit: frequencyUnit
      keepAtLeastOneBackup: true
      retentionPeriodInDays: retention
      startTime: startTime
    }
    databases: [
      {
        connectionString: 'Server=tcp:${serverName}.database.windows.net,1433;Initial Catalog=${dbName};Persist Security Info=False;User ID=${server.properties.administratorLogin};Password=${serverPass};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
        databaseType: dbType
        name: dbName
      }
    ]
    enabled: true
    storageAccountUrl: '${containerEndpoint}${container.name}?${sasToken}'
  }
}
