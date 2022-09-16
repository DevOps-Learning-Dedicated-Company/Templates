$RG = "testing"

#New-AzResourceGroup -Name $RG -Location "ukwest"

New-AzResourceGroupDeployment `
    -Name 'bicepContainerRegistry' `
    -ResourceGroupName $RG `
    -TemplateFile 'containerRegistry.bicep' `
    -rName 'bicepContainerRegistry01' `
    -location 'ukwest' `
    -Verbose