
provider "google" {
  project = var.project_id_spoke1
}

provider "google-beta" {
  project = var.project_id_spoke1
}

# remote state

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
  vpc    = data.terraform_remote_state.spoke1.outputs.spoke1.vpc
  subnet = data.terraform_remote_state.spoke1.outputs.spoke1.subnet
  sa = {
    spoke1 = data.terraform_remote_state.spoke1.outputs.spoke1.sa
    spoke2 = data.terraform_remote_state.spoke2.outputs.spoke2.sa
  }
}
