
provider "google" {}
provider "google-beta" {}

# remote state

data "terraform_remote_state" "spoke1" {
  backend = "local"

  config = {
    path = "../../2-spokes/spoke1/terraform.tfstate"
  }
}

data "terraform_remote_state" "hub" {
  backend = "local"

  config = {
    path = "../../1-hub/terraform.tfstate"
  }
}

locals {
  hub_vpc_trust1 = data.terraform_remote_state.hub.outputs.hub.vpc.trust1
  spoke1_vpc     = data.terraform_remote_state.spoke1.outputs.spoke1.vpc
}
