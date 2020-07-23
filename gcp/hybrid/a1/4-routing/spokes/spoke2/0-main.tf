
provider "google" {
  project = var.project_id_spoke2
}

provider "google-beta" {
  project = var.project_id_spoke2
}

# remote state

data "terraform_remote_state" "spoke2" {
  backend = "local"

  config = {
    path = "../../../2-spokes/spoke2/terraform.tfstate"
  }
}

# local

locals {
  vpc    = data.terraform_remote_state.spoke2.outputs.spoke2.vpc
  subnet = data.terraform_remote_state.spoke2.outputs.spoke2.subnet
}
