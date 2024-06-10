# Output Values
output "mysql_server_fqdn" {
  description = "MySQL Server FQDN"
  value = azurerm_mysql_flexible_server.mysql_flexible_server.fqdn
}