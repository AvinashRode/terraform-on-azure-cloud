business_divsion = "covid-reporting"
environment = "dev"
resource_group_name = "rg" #PowerBI
resource_group_location = "germanywestcentral"
vnet_name = "vnet"
vnet_address_space = ["10.1.0.0/16"]

sql_subnet_name = "sqlsubnet"
sql_subnet_address = ["10.1.1.0/24"]

#bastion_subnet_name = "bastionsubnet"
#bastion_subnet_address = ["10.1.100.0/24"]

#bastion_service_subnet_name = "AzureBastionSubnet"
#bastion_service_address_prefixes = ["10.1.101.0/27"]
#web_vmss_nsg_inbound_ports = [22, 80, 443, 8080]

storage_account_name              = "sa"
storage_account_tier              = "Standard"
storage_account_replication_type  = "LRS"
storage_account_kind              = "StorageV2"
static_website_index_document     = "index.html"
static_website_error_404_document = "error.html"

data_factory_name = "df"
data_lake_sa_name ="dl"