
provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

data "terraform_remote_state" "network" {
  backend = "local"

  config = {
    path = "../1-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "compute" {
  backend = "local"

  config = {
    path = "../3-compute/terraform.tfstate"
  }
}

locals {
  vpc1               = data.terraform_remote_state.network.outputs.network.vpc1
  default_hc         = data.terraform_remote_state.compute.outputs.health_check
  mqtt_tcp_proxy_vip = data.terraform_remote_state.network.outputs.mqtt_tcp_proxy_vip
  templates          = data.terraform_remote_state.compute.outputs.templates
}
