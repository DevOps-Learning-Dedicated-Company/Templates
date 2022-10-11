$RG = "testing"

#New-AzResourceGroup -Name $RG -Location "ukwest"

New-AzResourceGroupDeployment `
    -Name "aks-cluster-for-catalogAPI" `
    -ResourceGroupName $RG `
    -TemplateFile 'aks.json' `
    -TemplateParameterFile 'aks.parameters.json' `
    -Verbose
