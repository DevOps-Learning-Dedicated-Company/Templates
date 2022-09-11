$RG = "testingARM"
$S = ConvertTo-SecureString "SuperDuperMegaGigaSecretValue" -AsPlainText -Force

New-AzResourceGroupDeployment `
    -Name 'kayVaultarm' `
    -ResourceGroupName $RG `
    -TemplateFile 'keyvault.json' `
    -keyVaultName 'arm-keyvault2137' `
    -objectId 'db9a8fca-ab01-4f7d-af7b-c38eb530d78b' `
    -secretName 'SuperSecret' `
    -secretValue $S `
    -Verbose

secretValue to be replaced with secrets in github or azure devops

New-AzResourceGroupDeployment `
    -Name 'armAppConfig' `
    -ResourceGroupName $RG `
    -TemplateFile 'appconfig.json' `
    -configName 'arm-appconfig' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "managedId" `
    -ResourceGroupName $RG `
    -TemplateFile 'managedIdentity.json' `
    -serviceName 'appservice420' `
    -appName 'linuxbasedapp420' `
    -region 'ukwest' `
    -pricingTier 'S1' `
    -nodes '1' `
    -dockerImage 'hompus.azurecr.io/samples/nginx:latest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "assign-managed-id-to-key-vault" `
    -ResourceGroupName $RG `
    -TemplateFile 'manid-to-vault.json' `
    -appName 'linuxbasedapp420' `
    -keyVaultName 'arm-keyvault2137' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "app-configuration-role-assignment-to-webapp" `
    -ResourceGroupName $RG `
    -TemplateFile 'role.json' `
    -appName 'linuxbasedapp420' `
    -configName 'arm-appconfig' `
    -Verbose

