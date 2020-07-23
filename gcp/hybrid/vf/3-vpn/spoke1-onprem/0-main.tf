
provider "google" {}
provider "google-beta" {}

provider "aws" {
  region = "eu-west-1"
}

# remote state

data "terraform_remote_state" "spoke1" {
  backend = "local"

  config = {
    path = "../../2-spokes/spoke1/terraform.tfstate"
  }
}

data "terraform_remote_state" "onprem" {
  backend = "local"

  config = {
    path = "../../1-onprem/terraform.tfstate"
  }
}

locals {
  vpc_spoke1 = data.terraform_remote_state.hub.outputs.hub.vpc.untrust
  aws = {
    vpc       = data.terraform_remote_state.onprem.outputs.onprem.vpc
    pub_rtb_a = data.terraform_remote_state.onprem.outputs.onprem.pub_rtb_a
    pub_rtb_b = data.terraform_remote_state.onprem.outputs.onprem.pub_rtb_b
    prv_rtb_a = data.terraform_remote_state.onprem.outputs.onprem.prv_rtb_a
    prv_rtb_b = data.terraform_remote_state.onprem.outputs.onprem.prv_rtb_b
  }
}
