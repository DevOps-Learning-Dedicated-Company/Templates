$RG = "testing"

#New-AzResourceGroup -Name $RG -Location "ukwest"

New-AzResourceGroupDeployment `
    -Name 'app-insights-deployment' `
    -ResourceGroupName $RG `
    -TemplateFile 'appInsights.json' `
    -iName 'armAppInsight01' `
    -location 'ukwest' `
    -requestSource 'CustomDeployment' `
    -tName 'armTest' `
    -testKind 'standard' `
    -httpverb 'GET' `
    -url 'https://google.com' `
    -responseCode '200' `
    -Verbose
