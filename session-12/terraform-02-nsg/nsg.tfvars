rg = "testingARM"
location = "ukwest"
nsgName = "tf-nsg"
rules = [
    {
        name                        = "test123"
        priority                    = 100
        direction                   = "Outbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "*"
        source_address_prefix       = "*"
        destination_address_prefix  = "*"
    }
  ]
