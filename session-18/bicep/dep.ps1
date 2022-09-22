$RG = "testing"

#New-AzResourceGroup -Name $RG -Location "ukwest"

# New-AzResourceGroupDeployment `
#     -Name 'bicep-app-insights-deployment' `
#     -ResourceGroupName $RG `
#     -TemplateFile 'appInsights.bicep' `
#     -iName 'bicepAppInsight01' `
#     -location 'ukwest' `
#     -requestSource 'CustomDeployment' `
#     -tName 'bicepTest' `
#     -testKind 'standard' `
#     -httpverb 'GET' `
#     -url 'https://google.com' `
#     -responseCode '200' `
#     -Verbose

New-AzResourceGroupDeployment `
    -Name 'bicep-app-service-plan-dashboard' `
    -ResourceGroupName $RG `
    -TemplateFile 'appServicePlanDash.bicep' `
    -appServiceName 'appservice420' `
    -appServiceRG 'testing' `
    -dashboardName 'bicepTest01' `
    -dashboardDisplayName 'bicepTest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'bicep-app-service-dashboard' `
    -ResourceGroupName $RG `
    -TemplateFile 'appServiceDash.bicep' `
    -appServiceName 'linuxbasedapp420' `
    -appServiceRG 'testing' `
    -dashboardName 'bicepAppService' `
    -dashboardDisplayName 'bicepAppService' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'bicep-app-gat-dashboard' `
    -ResourceGroupName $RG `
    -TemplateFile 'appGatDash.bicep' `
    -appGatName 'appgat01' `
    -appServiceRG 'testing' `
    -dashboardName 'bicepAppGat' `
    -dashboardDisplayName 'bicepAppGat' `
    -Verbose
