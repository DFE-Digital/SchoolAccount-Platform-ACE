variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "ace_environment_name" {
  type = string
}

variable "shared_resource_group_name" {
  type = string
}

variable "core_resource_group_name" {
  type = string
}

variable "infrastructure_resource_group_name" {
  type = string
}

variable "log_analytics_workspace_name" {
  type = string
}

variable "application_insights_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "ace_subnet_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "logs_destination" {
  type = string
}

variable "diagnostic_log_categories" {
  type = list(string)
}
