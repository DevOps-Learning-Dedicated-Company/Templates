param keyVaultName string
param appName string

@description('secrets privileges')
@allowed([
  'all'
  'backup'
  'delete'
  'get'
  'list'
  'purge'
  'recover'
  'restore'
  'set'
])
param secretsPermissions array = [
  'get'
  'list'
]

resource keyVaultName_add 'Microsoft.KeyVault/vaults/accessPolicies@2021-11-01-preview' = {
  name: '${keyVaultName}/add'
  properties: {
    accessPolicies: [
      {
        objectId: reference(resourceId('Microsoft.Web/sites', appName), '2022-03-01', 'full').identity.principalId
        tenantId: subscription().tenantId
        permissions: {
          secrets: secretsPermissions
        }
      }
    ]
  }
}
