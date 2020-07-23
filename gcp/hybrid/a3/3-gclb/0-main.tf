
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
  prefix = "gclb-"
  vpc    = data.terraform_remote_state.vpc.outputs.vpc.vpc
  subnet = {
    ovpn  = data.terraform_remote_state.vpc.outputs.vpc.subnet.ovpn
    gclb  = data.terraform_remote_state.vpc.outputs.vpc.subnet.gclb
    ilb   = data.terraform_remote_state.vpc.outputs.vpc.subnet.ilb
    tcp   = data.terraform_remote_state.vpc.outputs.vpc.subnet.tcp
    proxy = data.terraform_remote_state.vpc.outputs.vpc.subnet.proxy
  }
  ip = {
    ovpn_ext_ip = data.terraform_remote_state.vpc.outputs.vpc.ip.ovpn_ext_ip
    gclb_vip    = data.terraform_remote_state.vpc.outputs.vpc.ip.gclb_vip
    tcp_vip    = data.terraform_remote_state.vpc.outputs.vpc.ip.tcp_vip
  }
}
