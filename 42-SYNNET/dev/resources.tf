resource "azurerm_storage_account" "data_lake_storage_account" {
  name                     = "${var.business_division}${var.environment}${var.storage_account_name}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true  # Enable hierarchical namespace (ADLS Gen2)

  tags = local.common_tags
}

resource "azurerm_data_factory" "data_factory" {
  name                = "${local.resource_name_prefix}-${var.data_factory_name}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = local.common_tags
}

output "storage_account_id" {
  value = azurerm_storage_account.data_lake_storage_account.id
}

output "data_factory_id" {
  value = azurerm_data_factory.data_factory.id
}
