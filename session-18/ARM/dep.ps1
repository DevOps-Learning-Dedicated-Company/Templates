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
    
New-AzResourceGroupDeployment `
    -Name 'arm-app-service-plan-dashboard' `
    -ResourceGroupName $RG `
    -TemplateFile 'appServicePlanDash.json' `
    -appServiceName 'appservice420' `
    -appServiceRG 'testing' `
    -dashboardDisplayName 'testTest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'arm-app-service-dashboard' `
    -ResourceGroupName $RG `
    -TemplateFile 'appServiceDash.json' `
    -appServiceName 'linuxbasedapp420' `
    -appServiceRG 'testing' `
    -dashboardName 'armAppService' `
    -dashboardDisplayName 'armAppService' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'arm-app-gat-dashboard' `
    -ResourceGroupName $RG `
    -TemplateFile 'appGatDash.json' `
    -appGatName 'appgat01' `
    -appServiceRG 'testing' `
    -dashboardName 'armAppGat' `
    -dashboardDisplayName 'armAppGat' `
    -Verbose
