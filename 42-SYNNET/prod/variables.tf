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
