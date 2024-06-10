# Resource-1: Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name = "${local.resource_name_prefix}-${var.resource_group_name}-${random_string.myrandom.id}"
  location = var.resource_group_location
  tags = local.common_tags
}


/*
# Reference an existing resource group
data "azurerm_resource_group" "existing_rg" {
  name = "PowerBI"
  location = var.resource_group_location
  tags = local.common_tags
}

# Resource-1: Azure Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "myVirtualNetwork"
  address_space       = ["10.1.0.0/16"]
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
}
*/