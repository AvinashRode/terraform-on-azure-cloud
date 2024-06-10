# Virtual Network, Subnets and Subnet NSG's

## Virtual Network
variable "vnet_name" {
  description = "Virtual Network name"
  type = string
  default = "vnet-default"
}
variable "vnet_address_space" {
  description = "Virtual Network address_space"
  type = list(string)
  default = ["10.0.0.0/16"]
}

# Sql Subnet Name
variable "sql_subnet_name" {
  description = "Virtual Network sql Subnet Name"
  type = string
  default = "sqlsubnet"
}
# Web Subnet Address Space
variable "sql_subnet_address" {
  description = "Virtual Network Web Subnet Address Spaces"
  type = list(string)
  default = ["10.0.2.0/24"]
}
