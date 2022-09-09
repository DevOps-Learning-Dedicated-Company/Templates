$RG = "testingARM"

New-AzResourceGroupDeployment `
    -Name 'vnetint' `
    -ResourceGroupName $RG `
    -TemplateFile 'vnetintegration.json' `
    -location 'ukwest' `
    -appName 'appforvnetintegration' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'armPrivateEndpoint' `
    -ResourceGroupName $RG `
    -TemplateFile 'privateEndpoint.json' `
    -appName 'appforvnetintegration' `
    -vName 'appforvnetintegrationvnet' `
    -sName 'endpointSubnet' `
    -addressPrefix '10.0.1.0/24' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'connectionString' `
    -ResourceGroupName $RG `
    -TemplateFile 'connectionString.json' `
    -appName 'appforvnetintegration' `
    -serverName 'sqlservertest2137' `
    -dbName 'sqldb2137' `
    -pass 'Thisismydbpassword1!' `
    -Verbose

#pass will be switched to secrets

New-AzResourceGroupDeployment `
    -Name 'applicationGatewayforAppService' `
    -ResourceGroupName $RG `
    -TemplateFile 'appgateway.json' `
    -TemplateParameterFile 'appgateway.parameters.json' `
    -Verbose