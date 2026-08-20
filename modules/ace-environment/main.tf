resource "azurerm_container_app_environment" "this" {
  name                           = var.name
  location                       = var.location
  resource_group_name            = var.resource_group_name

  log_analytics_workspace_id     = var.log_analytics_workspace_id

  infrastructure_resource_group_name = var.infrastructure_resource_group_name
  infrastructure_subnet_id       = var.infrastructure_subnet_id
  internal_load_balancer_enabled = true
  
  workload_profile {
    name = "Consumption"
    workload_profile_type = "Consumption"
  }

  tags = var.tags
}