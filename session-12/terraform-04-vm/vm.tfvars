vmName = "tf-vm01"
vmImage = {
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
  version   = "latest"
}
vmSize     = "Standard_DS1_v2"
diskPricingTier   = "Standard_LRS"
vName   = "tf-vnet"
subnetName = "tf-subnet1"
location   = "ukwest"
rg     = "testingARM"
#nsgName    = "tf-nsg"