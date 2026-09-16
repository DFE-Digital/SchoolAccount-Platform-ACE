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

variable "logs_destination" {
  description = "Where ACE application logs are sent. 'log-analytics' writes to the workspace's ContainerApp*Logs_CL custom tables; 'azure-monitor' emits to Azure Monitor so diagnostic settings can route to the dedicated ContainerApp*Logs tables (required for ContainerAppHTTPLogs)."
  type        = string
  default     = "log-analytics"

  validation {
    condition     = contains(["log-analytics", "azure-monitor"], var.logs_destination)
    error_message = "logs_destination must be either 'log-analytics' or 'azure-monitor'."
  }
}

variable "diagnostic_log_categories" {
  description = "Diagnostic setting log categories to route to the Log Analytics Workspace. Empty list creates no diagnostic setting."
  type        = list(string)
  default     = []
}

variable "diagnostic_setting_name" {
  description = "Name of the diagnostic setting on the ACE"
  type        = string
  default     = "aca-logs"
}
