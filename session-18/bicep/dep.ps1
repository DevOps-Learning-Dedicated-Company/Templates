$RG = "testing"

#New-AzResourceGroup -Name $RG -Location "ukwest"

New-AzResourceGroupDeployment `
    -Name 'bicep-app-insights-deployment' `
    -ResourceGroupName $RG `
    -TemplateFile 'appInsights.bicep' `
    -iName 'bicepAppInsight01' `
    -location 'ukwest' `
    -requestSource 'CustomDeployment' `
    -tName 'bicepTest' `
    -testKind 'standard' `
    -httpverb 'GET' `
    -url 'https://google.com' `
    -responseCode '200' `
    -Verbose
