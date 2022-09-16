$RG = "testing"

#New-AzResourceGroup -Name $RG -Location "ukwest"

# New-AzResourceGroupDeployment `
#     -Name 'armContainerRegistry' `
#     -ResourceGroupName $RG `
#     -TemplateFile 'containerRegistry.json' `
#     -rName 'armContainerRegistry01' `
#     -location 'ukwest' `
#     -Verbose

New-AzResourceGroupDeployment `
    -Name 'armStaticWebsite' `
    -ResourceGroupName $RG `
    -TemplateFile 'staticWeb.json' `
    -sName 'armconforstaticweb' `
    -location 'ukwest' `
    -sku 'Standard_LRS' `
    -userId '/subscriptions/0caac0d7-05bb-4689-9c72-a9878636f4b6/resourcegroups/testing/providers/Microsoft.ManagedIdentity/userAssignedIdentities/testUserManagedId' `
    -Verbose