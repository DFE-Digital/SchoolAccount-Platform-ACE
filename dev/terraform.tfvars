location = "uksouth"

resource_group_name = "s268d01rg-uks-sa-ace"

infrastructure_resource_group_name = "s268d01rg-uks-sa-ace-lb"

ace_environment_name = "s268d01ace-sa01"

shared_resource_group_name = "s268d01rg-uks-sa-shared"

core_resource_group_name = "s268d01rg-uks-core"

log_analytics_workspace_name = "s268d01log-sa-shared"

application_insights_name = "s268d01appi-sa-shared"

vnet_name = "s268d01-uks-core-vn-01"

ace_subnet_name = "s268d01-uks-ace-sn-01"

tags = {
  "Environment"      = "Dev"
  "Parent Business"  = "Funding and Allocations"
  "Portfolio"        = "Education and Skills Funding Agency"
  "Product"          = "School Account"
  "Service"          = "Funding and Allocations"
  "Service Line"     = "Funding"
  "Service Offering" = "School Account"
}