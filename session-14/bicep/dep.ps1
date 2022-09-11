$RG = "testingARM"
$S = ConvertTo-SecureString "SuperDuperMegaGigaSecretValue" -AsPlainText -Force

New-AzResourceGroupDeployment `
    -Name 'kayVaultbicep' `
    -ResourceGroupName $RG `
    -TemplateFile 'keyvault.bicep' `
    -keyVaultName 'bicep-keyvault2137' `
    -objectId 'db9a8fca-ab01-4f7d-af7b-c38eb530d78b' `
    -secretName 'SuperSecret' `
    -secretValue $S `
    -Verbose

secretValue to be replaced with secrets in github or azure devops

New-AzResourceGroupDeployment `
    -Name 'bicepAppConfig' `
    -ResourceGroupName $RG `
    -TemplateFile 'appconfig.bicep' `
    -configName 'bicep-appconfig' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "managedIdbicep" `
    -ResourceGroupName $RG `
    -TemplateFile 'managedIdentity.bicep' `
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
    -TemplateFile 'manid-to-vault.bicep' `
    -appName 'linuxbasedapp420' `
    -keyVaultName 'bicep-keyvault2137' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "app-configuration-role-assignment-to-webapp" `
    -ResourceGroupName $RG `
    -TemplateFile 'role.bicep' `
    -appName 'linuxbasedapp420' `
    -configName 'bicep-appconfig' `
    -roleId '516239f1-63e1-4d78-a4de-a74fb236a071' `
    -Verbose

