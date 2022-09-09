$RG = "testingARM"

New-AzResourceGroupDeployment `
    -Name "vnets" `
    -ResourceGroupName $RG `
    -TemplateFile 'vnets.json' `
    -TemplateParameterFile "vnets.parameters.json" `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'nsg-and-assign' `
    -ResourceGroupName $RG `
    -TemplateFile 'nsg-and-assign.json' `
    -region 'ukwest' `
    -nsgName 'arm-nsg' `
    -rules "AllowAll", "AllowAllOutbound", "Tcp", "*", "*", "*", "*", "Allow", 100, "Outbound" `
    -subnet 'arm-subnet1', '10.0.1.0/24' `
    -virtualNetworkName 'arm-vnet' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name 'vm' `
    -ResourceGroupName $RG `
    -TemplateFile 'vm.json' `
    -vmName 'arm-vm-01' `
    -vmImageReference "Canonical", "UbuntuServer", "18.04-LTS", "latest" `
    -vmPricingTier 'Standard_D2_v3' `
    -diskPricingTier 'Standard_LRS' `
    -vnet 'arm-vnet' `
    -subnet 'arm-subnet1' `
    -username 'bmaslick' `
    -pass 'Thisismyvmpassword1!' `
    -Verbose


New-AzResourceGroupDeployment `
    -Name 'applicationGateway' `
    -ResourceGroupName $RG `
    -TemplateFile 'appgateway.json' `
    -location 'ukwest' `
    -gatName 'appgat01' `
    -wafRules 'OWASP', '3.2' `
    -wafName 'arm-waf' `
    -vName 'arm-vnet' `
    -subnet 'arm-subnet2' `
    -ipName 'wafpublicIP' `
    -Verbose

# New-AzResourceGroupDeployment `
#     -Name "vnets-bicep" `
#     -ResourceGroupName $RG `
#     -TemplateFile 'vnets.bicep' `
#     -TemplateParameterFile "vnets.parameters.json" `
#     -Verbose

# New-AzResourceGroupDeployment `
#     -Name 'nsg-and-assign-bicep' `
#     -ResourceGroupName $RG `
#     -TemplateFile 'nsg-and-assign.bicep' `
#     -region 'ukwest' `
#     -nsgName 'bicep-nsg' `
#     -rules "AllowAll", "AllowAllOutbound", "Tcp", "*", "*", "*", "*", "Allow", 100, "Outbound" `
#     -subnet 'bicep-subnet1', '10.0.1.0/24' `
#     -virtualNetworkName 'bicep-vnet' `
#     -Verbose

# New-AzResourceGroupDeployment `
#     -Name 'vm-bicep' `
#     -ResourceGroupName $RG `
#     -TemplateFile 'vm.bicep' `
#     -vmName 'bicep-vm-01' `
#     -vmImageReference "Canonical", "UbuntuServer", "18.04-LTS", "latest" `
#     -vmPricingTier 'Standard_D2_v3' `
#     -diskPricingTier 'Standard_LRS' `
#     -vnet 'bicep-vnet' `
#     -subnet 'bicep-subnet1' `
#     -username 'bmaslick' `
#     -pass 'Thisismyvmpassword1!' `
#     -Verbose

# New-AzResourceGroupDeployment `
#     -Name 'applicationGateway-bicep' `
#     -ResourceGroupName $RG `
#     -TemplateFile 'appgateway.bicep' `
#     -location 'ukwest' `
#     -gatName 'appgat01-bicep' `
#     -wafRules 'OWASP', '3.2' `
#     -wafName 'bicep-waf' `
#     -vName 'bicep-vnet' `
#     -subnet 'bicep-subnet2' `
#     -ipName 'wafpublicIP-bicep' `
#     -Verbose