resource "azurerm_resource_group" "ace" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

data "azurerm_virtual_network" "core" {
  name                = var.vnet_name
  resource_group_name = var.core_resource_group_name
}

data "azurerm_subnet" "ace" {
  name                 = var.ace_subnet_name
  virtual_network_name = data.azurerm_virtual_network.core.name
  resource_group_name  = var.core_resource_group_name
}

data "azurerm_log_analytics_workspace" "shared" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.shared_resource_group_name
}

data "azurerm_application_insights" "shared" {
  name                = var.application_insights_name
  resource_group_name = var.shared_resource_group_name
}

module "ace_environment" {
  source = "../modules/ace-environment"

  name                = var.ace_environment_name
  location            = var.location
  resource_group_name = azurerm_resource_group.ace.name

  log_analytics_workspace_id         = data.azurerm_log_analytics_workspace.shared.id
  infrastructure_subnet_id           = data.azurerm_subnet.ace.id
  infrastructure_resource_group_name = var.infrastructure_resource_group_name

  logs_destination          = var.logs_destination
  diagnostic_log_categories = var.diagnostic_log_categories

  tags = var.tags
}
