
provider "google" {
  project = var.project_id_hub
}

provider "google-beta" {
  project = var.project_id_hub
}

# remote state

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../1-vpc/terraform.tfstate"
  }
}

# local

locals {
  vpc = data.terraform_remote_state.vpc.outputs.vpc.vpc
  subnet = {
    ovpn = data.terraform_remote_state.vpc.outputs.vpc.subnet.ovpn
  }
  ip = {
    ovpn_ext_ip = data.terraform_remote_state.vpc.outputs.vpc.ip.ovpn_ext_ip
  }
}
