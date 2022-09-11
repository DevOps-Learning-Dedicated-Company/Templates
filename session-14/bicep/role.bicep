param configName string
param appName string

@description('id of a specific role that\'s going to be assigned')
param roleId string = '516239f1-63e1-4d78-a4de-a74fb236a071'

resource configName_resource 'Microsoft.AppConfiguration/configurationStores@2021-10-01-preview' existing = {
  name: configName
}

resource Microsoft_AppConfiguration_configurationStores_configName_roleId 'Microsoft.Authorization/roleAssignments@2020-10-01-preview' = {
  scope: configName_resource
  name: guid(resourceId('Microsoft.AppConfiguration/configurationStores', configName), roleId)
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleId)
    principalId: reference(resourceId('Microsoft.Web/sites', appName), '2022-03-01', 'Full').identity.principalId
  }
}
