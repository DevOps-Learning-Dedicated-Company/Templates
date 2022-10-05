$RG = "testing"

#New-AzResourceGroup -Name $RG -Location "ukwest"

New-AzResourceGroupDeployment `
    -Name "sql-for-bookingAPI" `
    -ResourceGroupName $RG `
    -TemplateFile 'sql.json' `
    -serverName 'bookingAPIserv' `
    -dbName 'bookingAPIdb' `
    -region 'ukwest' `
    -dbPricing 'Basic' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "appservie-for-bookingAPI" `
    -ResourceGroupName $RG `
    -TemplateFile 'appServiceBooking.json' `
    -serviceName 'booking-APIplan' `
    -appName 'bookingAPI2137' `
    -region 'ukwest' `
    -pricingTier 'B1' `
    -nodes '1' `
    -dockerImage 'parteg132/booking-api-actions:latest' `
    -Verbose

New-AzResourceGroupDeployment `
    -Name "appservice-for-catalogAPI" `
    -ResourceGroupName $RG `
    -TemplateFile 'appService.json' `
    -serviceName 'catalogAPIplan' `
    -appName 'catalogAPI01' `
    -region 'ukwest' `
    -pricingTier 'B1' `
    -nodes '1' `
    -dockerImage 'parteg132/catalog-api-image-actions-v2:latest' `
    -Verbose