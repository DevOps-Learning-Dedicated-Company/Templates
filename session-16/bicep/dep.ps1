$RG = "testing"

#New-AzResourceGroup -Name $RG -Location "ukwest"

New-AzResourceGroupDeployment `
    -Name 'bicepContainerRegistry' `
    -ResourceGroupName $RG `
    -TemplateFile 'containerRegistry.bicep' `
    -rName 'bicepContainerRegistry01' `
    -location 'ukwest' `
    -Verbose
    
New-AzResourceGroupDeployment `
    -Name 'bicepStaticWebsite' `
    -ResourceGroupName $RG `
    -TemplateFile 'staticWeb.bicep' `
    -sName 'bicepconforstaticweb' `
    -location 'ukwest' `
    -sku 'Standard_LRS' `
    -iName 'bicepUserId01' `
    -Verbose
