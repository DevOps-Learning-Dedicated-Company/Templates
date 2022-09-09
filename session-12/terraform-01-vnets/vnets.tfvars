rg = "testingARM"
location = "ukwest"
vName = "tf-vnet"
vAddress = "10.0.0.0/16"
subnets = [
        {
            name = "tf-subnet1"
            address_prefix = "10.0.1.0/24"
        },
        {
            name = "tf-subnet2"
            address_prefix = "10.0.2.0/24"
        },
        {
            name = "tf-subnet3"
            address_prefix = "10.0.3.0/24"
        }
    ]