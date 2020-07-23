
provider "google" {}
provider "google-beta" {}

# remote state

data "terraform_remote_state" "spoke2" {
  backend = "local"

  config = {
    path = "../../2-spokes/spoke2/terraform.tfstate"
  }
}

data "terraform_remote_state" "hub" {
  backend = "local"

  config = {
    path = "../../1-hub/terraform.tfstate"
  }
}

locals {
  hub_vpc_trust2 = data.terraform_remote_state.hub.outputs.hub.vpc.trust2
  spoke2_vpc     = data.terraform_remote_state.spoke2.outputs.spoke2.vpc
}
