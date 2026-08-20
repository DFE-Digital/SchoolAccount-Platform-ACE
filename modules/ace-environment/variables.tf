variable "name" {
  description = "Azure Container Apps Environment name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "infrastructure_resource_group_name" {
  description = "Name of the Azure managed infrastructure resource group"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace ID"
  type        = string
}

variable "infrastructure_subnet_id" {
  description = "ACE delegated subnet ID"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}