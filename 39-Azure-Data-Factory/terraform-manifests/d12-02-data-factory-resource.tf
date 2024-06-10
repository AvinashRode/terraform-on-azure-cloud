resource "azurerm_data_factory" "data_factory" {
  name                = "${local.resource_name_prefix}-${var.data_factory_name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}