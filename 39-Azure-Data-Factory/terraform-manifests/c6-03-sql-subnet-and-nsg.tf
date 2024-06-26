# Resource-1: Create SqlTier Subnet
resource "azurerm_subnet" "sqlsubnet" {
  name                 = "${azurerm_virtual_network.vnet.name}-${var.sql_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.sql_subnet_address 
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# Resource-2: Create Network Security Group (NSG)
resource "azurerm_network_security_group" "sql_subnet_nsg" {
  name                = "${azurerm_subnet.sqlsubnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource-3: Associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "sql_subnet_nsg_associate" {
  depends_on = [ azurerm_network_security_rule.sql_nsg_rule_inbound] # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created - Azure Provider Bug https://github.com/terraform-providers/terraform-provider-azurerm/issues/354  
  subnet_id                 = azurerm_subnet.sqlsubnet.id
  network_security_group_id = azurerm_network_security_group.sql_subnet_nsg.id
}

# Resource-4: Create NSG Rules
## Locals Block for Security Rules
locals {
  sql_inbound_ports_map = {
    "100" : "80", # If the key starts with a number, you must use the colon syntax ":" instead of "="
    "110" : "443",
    "120" : "22",
    "130" : "8080"
  } 
}
## NSG Inbound Rule for SqlTier Subnets
resource "azurerm_network_security_rule" "sql_nsg_rule_inbound" {
  for_each = local.sql_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value 
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.sql_subnet_nsg.name
}


