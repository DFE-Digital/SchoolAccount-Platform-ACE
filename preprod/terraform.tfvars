location = "uksouth"

resource_group_name = "s268t05rg-uks-sa-ace"

infrastructure_resource_group_name = "s268t05rg-uks-sa-ace-lb"

ace_environment_name = "s268t05ace-sa01"

shared_resource_group_name = "s268t05rg-uks-sa-shared"

core_resource_group_name = "s268t05rg-uks-core"

log_analytics_workspace_name = "s268t05log-sa-shared"

logs_destination = "azure-monitor"

diagnostic_log_categories = [
  "ContainerAppConsoleLogs",
  "ContainerAppSystemLogs",
  "ContainerAppHTTPLogs",
]

application_insights_name = "s268t05appi-sa-shared"

vnet_name = "s268t05-uks-core-vn-01"

ace_subnet_name = "s268t05-uks-ace-sn-01"

tags = {
  "Environment"      = "PreProd"
  "Parent Business"  = "Funding and Allocations"
  "Portfolio"        = "Education and Skills Funding Agency"
  "Product"          = "School Account"
  "Service"          = "Funding and Allocations"
  "Service Line"     = "Funding"
  "Service Offering" = "School Account"
}