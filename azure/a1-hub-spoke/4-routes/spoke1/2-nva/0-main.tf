
provider "azurerm" {
  skip_provider_registration = true
  features {}
}

# remote states

data "terraform_remote_state" "global" {
  backend = "local"

  config = {
    path = "../../../0-global/0-rg/terraform.tfstate"
  }
}

data "terraform_remote_state" "hub" {
  backend = "local"

  config = {
    path = "../../../1-hub/2-nva/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke1" {
  backend = "local"

  config = {
    path = "../../../2-spokes/spoke1/terraform.tfstate"
  }
}

locals {
  rg      = data.terraform_remote_state.global.outputs.rg
  azurefw = data.terraform_remote_state.hub.outputs.hub.azurefw
  spoke1 = {
    vnet = data.terraform_remote_state.spoke1.outputs.spoke1.vnet
    subnet = {
      wload = data.terraform_remote_state.spoke1.outputs.spoke1.subnet.wload
      jump  = data.terraform_remote_state.spoke1.outputs.spoke1.subnet.jump
    }
    nsg = {
      wload = data.terraform_remote_state.spoke1.outputs.spoke1.nsg.wload
      jump  = data.terraform_remote_state.spoke1.outputs.spoke1.nsg.jump
    }
  }
}
