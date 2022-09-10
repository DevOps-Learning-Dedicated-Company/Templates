@description('web app name for which the connection is going to be set')
param appName string

@description('name of database to connect to')
param dbName string

@description('database server name')
param serverName string

@description('db password')
param pass string

resource appName_resource 'Microsoft.Web/sites@2021-01-01' = {
  name: appName
  location: resourceGroup().location
  kind: 'app'
  properties: {
    httpsOnly: true
    siteConfig: {
      vnetRouteAllEnabled: true
      http20Enabled: true
      connectionStrings: [
        {
          name: 'sqlConString'
          connectionString: 'Server=tcp:${serverName}.database.windows.net,1433;Initial Catalog=${dbName};Persist Security Info=False;User ID=adminUsername;Password=${pass};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
        }
      ]
    }
  }
}