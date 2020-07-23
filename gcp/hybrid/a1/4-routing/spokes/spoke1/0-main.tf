
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
    path = "../../../2-spokes/spoke1/terraform.tfstate"
  }
}

# local

locals {
  vpc    = data.terraform_remote_state.spoke1.outputs.spoke1.vpc
  subnet = data.terraform_remote_state.spoke1.outputs.spoke1.subnet
}
