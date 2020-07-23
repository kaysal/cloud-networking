
provider "azurerm" {
  skip_provider_registration = true
  features {}
}

data "azurerm_client_config" "current" {}

data "terraform_remote_state" "rg" {
  backend = "local"

  config = {
    path = "../../0-global/0-rg/terraform.tfstate"
  }
}

locals {
  rg = data.terraform_remote_state.rg.outputs.rg
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
