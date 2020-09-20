
provider "google" {}
provider "google-beta" {}
provider "random" {}

data "terraform_remote_state" "vpc1" {
  backend = "local"

  config = {
    path = "../../1-gcp-hub/1-vpc1/1-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc2" {
  backend = "local"

  config = {
    path = "../../1-gcp-hub/2-vpc2/1-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "spoke" {
  backend = "local"

  config = {
    path = "../../2-gcp-spoke/1-spoke1/1-vpc/terraform.tfstate"
  }
}

locals {
  vpc1  = data.terraform_remote_state.vpc1.outputs.network.vpc1
  vpc2  = data.terraform_remote_state.vpc2.outputs.network.vpc2
  spoke = data.terraform_remote_state.spoke.outputs.network.vpc1
}
