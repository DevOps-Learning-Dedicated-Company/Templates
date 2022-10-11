RG='testing'

az deployment group create \
    --resource-group $RG \
    --template-file aks.json \
    --parameters @aks.parameters.json \
    --verbose