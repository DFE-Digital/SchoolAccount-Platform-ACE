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

data "azurerm_key_vault" "shared" {
  name                = var.key_vault_name
  resource_group_name = var.shared_resource_group_name
}

data "azurerm_client_config" "current" {}

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

resource "azurerm_key_vault_access_policy" "ace_environment" {
 key_vault_id = data.azurerm_key_vault.shared.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = module.ace_environment.principal_id

  secret_permissions = [
    "Get"
  ]

  certificate_permissions = [
    "Get"
  ]
}