
provider "azurerm" {}

# remote states

data "terraform_remote_state" "hub" {
  backend = "local"

  config = {
    path = "../../../1-hub/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke1" {
  backend = "local"

  config = {
    path = "../../../2-spokes/spoke1/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke2" {
  backend = "local"

  config = {
    path = "../../../2-spokes/spoke2/terraform.tfstate"
  }
}

data "terraform_remote_state" "global" {
  backend = "local"

  config = {
    path = "../../../0-global/0-rg/terraform.tfstate"
  }
}

locals {
  rg      = data.terraform_remote_state.global.outputs.rg
  azurefw = data.terraform_remote_state.hub.outputs.hub.azurefw
  hub = {
    vnet = data.terraform_remote_state.hub.outputs.hub.vnet
    subnet = {
      azurefw = data.terraform_remote_state.hub.outputs.hub.subnet.azurefw
    }
  }
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
