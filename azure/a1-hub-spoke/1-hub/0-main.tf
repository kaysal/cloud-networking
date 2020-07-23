
provider "azurerm" {
  skip_provider_registration = true
  features {}
}

data "terraform_remote_state" "global" {
  backend = "local"

  config = {
    path = "../0-global/0-rg/terraform.tfstate"
  }
}

data "azurerm_log_analytics_workspace" "analytics_ws" {
  resource_group_name = local.rg.global.name
  name                = "a1-analytics-ws"
}

locals {
  rg = data.terraform_remote_state.global.outputs.rg
}

locals {
  diag_nsg = {
    logs = [
      "NetworkSecurityGroupEvent",
      "NetworkSecurityGroupRuleCounter",
    ]
  }
  diag_ip = {
    logs = [
      "DDoSProtectionNotifications",
      "DDoSMitigationFlowLogs",
      "DDoSMitigationReports"
    ]
    metrics = ["AllMetrics"]
  }
  diag_interface = {
    metrics = ["AllMetrics"]
  }
  diag_key_vault = {
    logs    = ["AuditEvent"]
    metrics = ["AllMetrics"]
  }
  diag_azurefw = {
    logs = [
      "AzureFirewallApplicationRule",
      "AzureFirewallNetworkRule",
    ]
    metrics = ["AllMetrics"]
  }
}
