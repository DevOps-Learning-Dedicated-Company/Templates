$RG = "testingARM"

New-AzResourceGroupDeployment `
    -Name 'vnetint-bicep' `
    -ResourceGroupName $RG `
    -TemplateFile 'vnetintegration.bicep' `
    -location 'ukwest' `
    -appName 'appforvnetintegration' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'armPrivateEndpoint-bicep' `
    -ResourceGroupName $RG `
    -TemplateFile 'privateEndpoint.bicep' `
    -appName 'appforvnetintegration' `
    -vName 'appforvnetintegrationvnet' `
    -sName 'endpointSubnet' `
    -addressPrefix '10.0.1.0/24' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'connectionString-bicep' `
    -ResourceGroupName $RG `
    -TemplateFile 'connectionString.bicep' `
    -appName 'appforvnetintegration' `
    -serverName 'sqlservertest2137' `
    -dbName 'sqldb2137' `
    -pass 'Thisismydbpassword1!' `
    -Verbose

#pass will be switched to secrets

New-AzResourceGroupDeployment `
    -Name 'applicationGatewayforAppService-bicep' `
    -ResourceGroupName $RG `
    -TemplateFile 'appgateway.bicep' `
    -TemplateParameterFile 'appgateway.parameters.json' `
    -Verbose