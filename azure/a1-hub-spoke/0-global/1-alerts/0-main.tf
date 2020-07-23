
provider "azurerm" {
  skip_provider_registration = true
  features {}
}

data "azurerm_client_config" "current" {}

data "terraform_remote_state" "global" {
  backend = "local"

  config = {
    path = "../../0-global/0-rg/terraform.tfstate"
  }
}

locals {
  rg = {
    global = data.terraform_remote_state.global.outputs.rg.global
    hub    = data.terraform_remote_state.global.outputs.rg.hub
    spoke1 = data.terraform_remote_state.global.outputs.rg.spoke1
    spoke2 = data.terraform_remote_state.global.outputs.rg.spoke2
  }
}
