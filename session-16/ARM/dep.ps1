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
    -iName 'armUserId01' `
    -Verbose
