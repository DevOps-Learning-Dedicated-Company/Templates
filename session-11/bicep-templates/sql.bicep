param serverName string
param region string
param dbName string
param dbPricing string

@allowed([
  'Geo'
  'GeoZone'
  'Local'
  'Zone'
])
param dbBackupPolicy string
param firewallRules array

resource serverName_resource 'Microsoft.Sql/servers@2021-11-01-preview' = {
  name: serverName
  location: region
  tags: {
    displayName: serverName
  }
  properties: {
    administratorLogin: 'adminUsername'
    administratorLoginPassword: 'Thisismysqlpassword1'
  }
}

resource serverName_AllowAllWindowsAzureIps 'Microsoft.Sql/servers/firewallRules@2021-11-01-preview' = {
  parent: serverName_resource
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: first(firewallRules)
    endIpAddress: last(firewallRules)
  }
}

resource serverName_dbName 'Microsoft.Sql/servers/databases@2021-11-01-preview' = {
  parent: serverName_resource
  name: dbName
  location: region
  tags: {
    displayName: dbName
  }
  sku: {
    name: dbPricing
    tier: dbPricing
  }
  properties: {
    requestedBackupStorageRedundancy: dbBackupPolicy
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 1073741824
  }
}
