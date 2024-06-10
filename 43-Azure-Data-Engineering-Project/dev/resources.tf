
# Existing Storage Account
resource "azurerm_storage_account" "data_lake_storage_account" {
  name                     = "${var.business_division}${var.environment}${var.storage_account_name}"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true  # Enable hierarchical namespace (ADLS Gen2)

  tags = local.common_tags
}

resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake_gen2_filesystem" {
  name               = "${var.business_division}${var.environment}${var.data_lake_gen2_filesystem_name}"
  storage_account_id = azurerm_storage_account.data_lake_storage_account.id
}

# Existing Data Factory
resource "azurerm_data_factory" "data_factory" {
  name                = "${local.resource_name_prefix}-${var.data_factory_name}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  tags = local.common_tags
}

# Azure Databricks Workspace
resource "azurerm_databricks_workspace" "databricks_workspace" {
  name                = "${var.business_division}-${var.environment}-databricks"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "standard"

  tags = local.common_tags
}

# Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                = "${var.business_division}-${var.environment}-kv"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  tags = local.common_tags
}

# Azure Synapse Workspace
resource "azurerm_synapse_workspace" "synapse_workspace" {
  name                                  = "${var.business_division}-${var.environment}-synapse"
  resource_group_name                   = data.azurerm_resource_group.rg.name
  location                              = data.azurerm_resource_group.rg.location
  sql_administrator_login               = var.sql_administrator_login
  sql_administrator_login_password      = var.sql_administrator_login_password
  storage_data_lake_gen2_filesystem_id  = azurerm_storage_data_lake_gen2_filesystem.data_lake_gen2_filesystem.id
  tags                                  = local.common_tags

  depends_on = [azurerm_storage_data_lake_gen2_filesystem.data_lake_gen2_filesystem]
}

# Output the IDs of the created resources
output "storage_account_id" {
  value = azurerm_storage_account.data_lake_storage_account.id
}

output "data_factory_id" {
  value = azurerm_data_factory.data_factory.id
}

output "databricks_workspace_id" {
  value = azurerm_databricks_workspace.databricks_workspace.id
}

output "key_vault_id" {
  value = azurerm_key_vault.key_vault.id
}

output "synapse_workspace_id" {
  value = azurerm_synapse_workspace.synapse_workspace.id
}
