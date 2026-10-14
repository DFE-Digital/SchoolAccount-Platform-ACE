variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group created for the ACE"
  type        = string
}

variable "ace_environment_name" {
  description = "Azure Container Apps Environment name"
  type        = string
}

variable "shared_resource_group_name" {
  description = "Name of the existing Resource Group holding the shared resources (Log Analytics, Application Insights, Key Vault)"
  type        = string
}

variable "core_resource_group_name" {
  description = "Name of the existing Resource Group holding the core network"
  type        = string
}

variable "infrastructure_resource_group_name" {
  description = "Name of the Azure managed infrastructure resource group created for the ACE"
  type        = string
}

variable "log_analytics_workspace_name" {
  description = "Name of the existing shared Log Analytics Workspace"
  type        = string
}

variable "application_insights_name" {
  description = "Name of the existing shared Application Insights instance"
  type        = string
}

variable "vnet_name" {
  description = "Name of the existing core Virtual Network"
  type        = string
}

variable "ace_subnet_name" {
  description = "Name of the existing subnet in the core Virtual Network delegated to the ACE"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

variable "logs_destination" {
  description = "Where ACE application logs are sent: 'log-analytics' or 'azure-monitor'. See the ace-environment module for details."
  type        = string
}

variable "diagnostic_log_categories" {
  description = "Diagnostic setting log categories to route to the Log Analytics Workspace. Empty list creates no diagnostic setting."
  type        = list(string)
}

variable "key_vault_name" {
  description = "Name of the existing shared Key Vault the ACE is granted Get access to for secrets and certificates"
  type        = string
}
