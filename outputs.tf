output "resource_group_name" {
  description = "Name of the Resource Group holding the ACE"
  value       = azurerm_resource_group.ace.name
}

output "ace_environment_id" {
  description = "Azure Container Apps Environment ID"
  value       = module.ace_environment.id
}

output "ace_environment_name" {
  description = "Azure Container Apps Environment name"
  value       = module.ace_environment.name
}

output "ace_default_domain" {
  description = "Default domain of the Azure Container Apps Environment"
  value       = module.ace_environment.default_domain
}

output "ace_static_ip_address" {
  description = "Static IP address of the Azure Container Apps Environment's internal load balancer"
  value       = module.ace_environment.static_ip_address
}

output "ace_principal_id" {
  description = "Principal ID of the ACE's system-assigned managed identity"
  value       = module.ace_environment.principal_id
}
