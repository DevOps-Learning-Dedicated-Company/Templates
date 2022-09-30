$RG = "testing"

New-AzResourceGroup -Name $RG -Location "ukwest"

New-AzResourceGroupDeployment `
    -Name "appservice" `
    -ResourceGroupName $RG `
    -TemplateFile 'appService.json' `
    -serviceName 'host-01plan' `
    -appName 'host-01' `
    -region 'uksouth' `
    -pricingTier 'S1' `
    -nodes '1' `
    -dockerImage 'parteg132/webserver:latest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "appservice" `
    -ResourceGroupName $RG `
    -TemplateFile 'appService.json' `
    -serviceName 'host-02plan' `
    -appName 'host-02' `
    -region 'ukwest' `
    -pricingTier 'S1' `
    -nodes '1' `
    -dockerImage 'parteg132/website02:latest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "appservice" `
    -ResourceGroupName $RG `
    -TemplateFile 'appService.json' `
    -serviceName 'dr2137plan' `
    -appName 'dr2137' `
    -region 'ukwest' `
    -pricingTier 'S1' `
    -nodes '1' `
    -dockerImage 'parteg132/sorrypage:latest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "traffic-manager-deployment" `
    -ResourceGroupName $RG `
    -TemplateFile 'tm.json' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "front-door-deployment" `
    -ResourceGroupName $RG `
    -TemplateFile 'fd.json' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'app-insights-deployment' `
    -ResourceGroupName $RG `
    -TemplateFile 'appInsights.json' `
    -iName 'appInsightHost-01' `
    -location 'ukwest' `
    -requestSource 'CustomDeployment' `
    -tName 'host-01test' `
    -testKind 'standard' `
    -httpverb 'GET' `
    -url 'https://host-01.azurewebsites.net' `
    -responseCode '200' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'app-insights-deployment' `
    -ResourceGroupName $RG `
    -TemplateFile 'appInsights.json' `
    -iName 'appInsightHost-02' `
    -location 'ukwest' `
    -requestSource 'CustomDeployment' `
    -tName 'host-02test' `
    -testKind 'standard' `
    -httpverb 'GET' `
    -url 'https://host-02.azurewebsites.net' `
    -responseCode '200' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'app-insights-deployment' `
    -ResourceGroupName $RG `
    -TemplateFile 'appInsights.json' `
    -iName 'appInsightTrafficManager' `
    -location 'ukwest' `
    -requestSource 'CustomDeployment' `
    -tName 'trafficManagerTest' `
    -testKind 'standard' `
    -httpverb 'GET' `
    -url 'http://tm2137.trafficmanager.net' `
    -ssl $False `
    -responseCode '200' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'app-insights-deployment' `
    -ResourceGroupName $RG `
    -TemplateFile 'appInsights.json' `
    -iName 'appInsightFrontDoor' `
    -location 'ukwest' `
    -requestSource 'CustomDeployment' `
    -tName 'frontDoorTest' `
    -testKind 'standard' `
    -httpverb 'GET' `
    -url 'https://site-01-hcfkfafkh3d6b8e4.z01.azurefd.net' `
    -responseCode '200' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'automation-account-deployment' `
    -ResourceGroupName $RG `
    -TemplateFile 'autoAcc.json' `
    -workspaceName 'autoworkspacehost1' `
    -uri 'https://raw.githubusercontent.com/DevOps-Learning-Dedicated-Company/Templates/main/session-20/script1.ps1' `
    -startTime1 '2022-09-30T18:00:00+02:00' `
    -startTime2 '2022-09-30T18:30:00+02:00' `
    -aName 'autoAccHost01' `
    -location 'ukwest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'automation-account-deployment' `
    -ResourceGroupName $RG `
    -TemplateFile 'autoAcc.json' `
    -workspaceName 'autoworkspacehost2' `
    -uri 'https://raw.githubusercontent.com/DevOps-Learning-Dedicated-Company/Templates/main/session-20/script2.ps1' `
    -startTime1 '2022-09-30T18:15:00+02:00' `
    -startTime2 '2022-09-30T18:45:00+02:00' `
    -aName 'autoAccHost02' `
    -location 'ukwest' `
    -Verbose