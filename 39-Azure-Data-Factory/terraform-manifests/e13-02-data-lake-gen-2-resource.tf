# Resource-1: Create Azure Storage account
resource "azurerm_storage_account" "data-lake-storage-account-gen-2" {
  name                = "${var.data_lake_sa_name}${random_string.myrandom.id}"
  resource_group_name = azurerm_resource_group.rg.name

  location                 = var.resource_group_location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
  enable_https_traffic_only = true
  is_hns_enabled = true  # Enabling hierarchical namespace


  static_website {
    index_document     = var.static_website_index_document
    error_404_document = var.static_website_error_404_document
  }
}

