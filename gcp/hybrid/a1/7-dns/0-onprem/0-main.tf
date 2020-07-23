
provider "google" {
  project = var.project_id_onprem
}
provider "google-beta" {
  project = var.project_id_onprem
}

# remote state

data "terraform_remote_state" "onprem" {
  backend = "local"

  config = {
    path = "../../0-onprem/terraform.tfstate"
  }
}

data "terraform_remote_state" "hub" {
  backend = "local"

  config = {
    path = "../../1-hub/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke1" {
  backend = "local"

  config = {
    path = "../../2-spokes/spoke1/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke2" {
  backend = "local"

  config = {
    path = "../../2-spokes/spoke2/terraform.tfstate"
  }
}

# local

locals {
  onprem = {
    network = data.terraform_remote_state.onprem.outputs.onprem.vpc
  }
  hub = {
    network_untrust = data.terraform_remote_state.hub.outputs.hub.vpc.untrust
    network_trust1  = data.terraform_remote_state.hub.outputs.hub.vpc.trust1
    network_trust2  = data.terraform_remote_state.hub.outputs.hub.vpc.trust2
  }
  spoke1 = {
    network = data.terraform_remote_state.spoke1.outputs.spoke1.vpc
  }
  spoke2 = {
  network = data.terraform_remote_state.spoke2.outputs.spoke2.vpc }
}
