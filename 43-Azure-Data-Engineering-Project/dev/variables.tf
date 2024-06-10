variable "location" {
  description = "The location where resources will be created"
  type        = string
  default     = "North Europe"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "SYNNET"
}

variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
}

variable "data_lake_gen2_filesystem_name" {
  description = "The name of the data lake gen2 filesystem name"
  type        = string
}


variable "data_factory_name" {
  description = "The name of the Data Factory"
  type        = string
}

variable "business_division" {
  description = "The business division owner of the resources"
  type        = string
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

variable "sql_administrator_login" {
  description = "The administrator login for the Synapse SQL"
  type        = string
}

variable "sql_administrator_login_password" {
  description = "The administrator password for the Synapse SQL"
  type        = string
  sensitive   = true
}
