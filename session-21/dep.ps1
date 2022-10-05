$RG = "testing"

#New-AzResourceGroup -Name $RG -Location "ukwest"

New-AzResourceGroupDeployment `
    -Name "sql-for-bookingAPI" `
    -ResourceGroupName $RG `
    -TemplateFile 'sql.json' `
    -serverName 'bookingAPIserv' `
    -dbName 'bookingAPIdb' `
    -region 'ukwest' `
    -dbPricing 'Standard' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "appservie-for-bookingAPI" `
    -ResourceGroupName $RG `
    -TemplateFile 'appServiceBooking.json' `
    -serviceName 'booking-APIplan' `
    -appName 'bookingAPI2137' `
    -region 'uksouth' `
    -pricingTier 'S1' `
    -nodes '1' `
    -dockerImage 'parteg132/booking-api-actions:latest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "appservie-for-nginx" `
    -ResourceGroupName $RG `
    -TemplateFile 'appServiceNginx.json' `
    -serviceName 'nginxplan' `
    -appName 'nginx2137' `
    -region 'ukwest' `
    -pricingTier 'S1' `
    -nodes '1' `
    -dockerImage 'nginx:latest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "file-share-for-nginx" `
    -ResourceGroupName $RG `
    -TemplateFile 'fileShare.json' `
    -storageName 'nginxstorage01' `
    -shName 'nginxshare' `
    -region 'ukwest' `
    -skuName 'Standard_LRS' `
    -Verbose