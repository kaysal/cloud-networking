
provider "azurerm" {}

# remote states

data "terraform_remote_state" "rg" {
  backend = "local"

  config = {
    path = "../../0-global/0-rg/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke2" {
  backend = "local"

  config = {
    path = "../../2-spokes/spoke2/terraform.tfstate"
  }
}

data "azurerm_log_analytics_workspace" "analytics_ws" {
  resource_group_name = local.rg.global.name
  name                = "a1-analytics-ws"
}

locals {
  rg         = data.terraform_remote_state.rg.outputs.rg
  #action_grp = data.terraform_remote_state.action_grp.outputs.action_grp
  spoke2 = {
    vnet = data.terraform_remote_state.spoke2.outputs.spoke2.vnet
    subnet = {
      wload = data.terraform_remote_state.spoke2.outputs.spoke2.subnet.wload
      jump  = data.terraform_remote_state.spoke2.outputs.spoke2.subnet.jump
    }
    nsg = {
      wload = data.terraform_remote_state.spoke2.outputs.spoke2.nsg.wload
      jump  = data.terraform_remote_state.spoke2.outputs.spoke2.nsg.jump
    }
  }
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
