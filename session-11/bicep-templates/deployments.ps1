$RG = "testingARM"

#New-AzResourceGroup -Name $RG -Location "ukwest"

#New-AzResourceGroupDeployment `
#     -Name "sql" `
#     -ResourceGroupName $RG `
#     -TemplateFile 'sql.json' `
#     -serverName "sqlservertest2137" `
#     -region 'ukwest' `
#     -dbName 'sqldb2137' `
#     -dbPricing 'Standard' `
#     -dbBackupPolicy 'Local' `
#     -firewallRules ("0.0.0.0", "0.0.0.0") `
#     -Verbose

New-AzResourceGroupDeployment `
    -Name "sqlbicep" `
    -ResourceGroupName $RG `
    -TemplateFile 'sql.bicep' `
    -serverName "sqlservertest2137" `
    -region 'ukwest' `
    -dbName 'sqldb2137' `
    -dbPricing 'Standard' `
    -dbBackupPolicy 'Local' `
    -firewallRules ("0.0.0.0", "0.0.0.0") `
    -Verbose

#New-AzResourceGroupDeployment `
#     -Name "appservice" `
#     -ResourceGroupName $RG `
#     -TemplateFile 'appService.json' `
#     -serviceName 'appservice420' `
#     -appName 'linuxbasedapp420' `
#     -region 'ukwest' `
#     -pricingTier 'S1' `
#     -nodes '1' `
#     -dockerImage 'hompus.azurecr.io/samples/nginx:latest' `
#    -Verbose

New-AzResourceGroupDeployment `
    -Name "appservicebicep" `
    -ResourceGroupName $RG `
    -TemplateFile 'appService.bicep' `
    -serviceName 'appservicebicep420' `
    -appName 'linuxbasedappbicep420' `
    -region 'ukwest' `
    -pricingTier 'S1' `
    -nodes 1 `
    -dockerImage 'hompus.azurecr.io/samples/nginx:latest' `
    -Verbose

#New-AzResourceGroupDeployment `
#     -Name "storageacc" `
#     -ResourceGroupName $RG `
#     -TemplateFile 'storageAccount.json' `
#     -storageName 'storageaccount420' `
#     -region 'ukwest' `
#     -skuName 'Standard_LRS' `
#     -skuTier 'Standard' `
#     -Verbose

New-AzResourceGroupDeployment `
     -Name "storageAccBicep" `
     -ResourceGroupName $RG `
     -TemplateFile '.\storageAccount.bicep' `
     -storageName 'storageaccbicep6969' `
     -region 'ukwest' `
     -skuName 'Standard_LRS' `
     -Verbose
  
#New-AzResourceGroupDeployment `
#    -Name "backup" `
#    -ResourceGroupName $RG `
#    -TemplateFile 'backup.json' `
#    -storageName 'storageaccount420' `
#    -appName 'linuxbasedapp420' `
#    -scheduleInterval '1' `
#    -scheduleUnit 'day' `
#    -retention '10' `
#    -region 'ukwest' `
#    -serviceName 'appservice420' `
#    -pricingTier 'S1' `
#    -skuName 'Standard_LRS' `
#    -skuTier 'Standard' `
#    -Verbose

New-AzResourceGroupDeployment `
     -Name "backupbicep" `
     -ResourceGroupName $RG `
     -TemplateFile 'backup.bicep' `
     -storageName 'storageaccbicep6969' `
     -appName 'linuxbasedappbicep420' `
     -frequencyInterval 1 `
     -frequencyUnit 'day' `
     -retention 10 `
     -dbType 'SqlAzure' `
     -dbName 'sqldb2137' `
     -serverName 'sqlservertest2137' `
     -serverPass 'Thisismysqlpassword1' `
     -Verbose
