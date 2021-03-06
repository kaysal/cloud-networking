
provider "google" {
  project = var.project_id_spoke1
}

provider "google-beta" {
  project = var.project_id_spoke1
}

# remote state

data "terraform_remote_state" "hub" {
  backend = "local"

  config = {
    path = "../../1-hub/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke1" {
  backend = "local"

  config = {
    path = "../../4-spokes/spoke1/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke2" {
  backend = "local"

  config = {
    path = "../../4-spokes/spoke2/terraform.tfstate"
  }
}

# local

locals {
  vpc    = data.terraform_remote_state.hub.outputs.hub.vpc.trust1
  subnet = data.terraform_remote_state.hub.outputs.hub.subnet.spoke1
  sa = {
    spoke1 = data.terraform_remote_state.spoke1.outputs.spoke1.sa
    spoke2 = data.terraform_remote_state.spoke2.outputs.spoke2.sa
  }
}

locals {
  prefix_spoke1 = "${var.global.prefix}spoke1-"
}
