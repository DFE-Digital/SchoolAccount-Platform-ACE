resource "azurerm_container_app_environment" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  logs_destination           = var.logs_destination
  log_analytics_workspace_id = var.logs_destination == "log-analytics" ? var.log_analytics_workspace_id : null

  infrastructure_resource_group_name = var.infrastructure_resource_group_name
  infrastructure_subnet_id           = var.infrastructure_subnet_id
  internal_load_balancer_enabled     = true

  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count = length(var.diagnostic_log_categories) > 0 ? 1 : 0

  name                       = var.diagnostic_setting_name
  target_resource_id         = azurerm_container_app_environment.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_log_categories)

    content {
      category = enabled_log.value
    }
  }
}
