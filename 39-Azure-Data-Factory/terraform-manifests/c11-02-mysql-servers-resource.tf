
resource "azurerm_private_dns_zone" "private_dns_zone" {
  #name                = "${local.resource_name_prefix}-${var.private_dns_zone_name}"
  name = "demotest.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_network_link" {
  #name                  = "${local.resource_name_prefix}-${var.dns_network_link_name}"
  name = "demotest.com"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.rg.name
}

resource "azurerm_mysql_flexible_server" "mysql_flexible_server" {
  depends_on = [azurerm_private_dns_zone_virtual_network_link.dns_network_link]
  name                   = "${local.resource_name_prefix}-mysql-flexible-server"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  administrator_login    = "psqladmin"
  administrator_password = "H@Sh1CoR3!"
  delegated_subnet_id    = azurerm_subnet.sqlsubnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.private_dns_zone.id
  sku_name               = "B_Standard_B1s"
}

resource "azurerm_mysql_flexible_database" "mysql_flexible_db" {
  name                = "${local.resource_name_prefix}-mysql_flexible_db"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.mysql_flexible_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}