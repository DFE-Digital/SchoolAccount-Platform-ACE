output "id" {
  description = "Azure Container Apps Environment ID"
  value       = azurerm_container_app_environment.this.id
}

output "name" {
  description = "Azure Container Apps Environment name"
  value       = azurerm_container_app_environment.this.name
}

output "default_domain" {
  description = "Default domain of the Azure Container Apps Environment"
  value       = azurerm_container_app_environment.this.default_domain
}

output "static_ip_address" {
  description = "Static IP address of the Azure Container Apps Environment's internal load balancer"
  value       = azurerm_container_app_environment.this.static_ip_address
}

output "diagnostic_setting_id" {
  description = "ID of the diagnostic setting on the ACE, or null when none is created"
  value       = try(azurerm_monitor_diagnostic_setting.this[0].id, null)
}

output "principal_id" {
  description = "Principal ID of the ACE's system-assigned managed identity"
  value       = azurerm_container_app_environment.this.identity[0].principal_id
}
