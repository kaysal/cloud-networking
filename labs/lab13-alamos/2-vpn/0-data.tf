# provider

provider "google" {
  project = var.project_id
}

provider "google-beta" {
  project = var.project_id
}

# remote state

data "terraform_remote_state" "vpc" {
  backend = "local"

  config = {
    path = "../1-vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "vpc_nic" {
  backend = "local"

  config = {
    path = "/home/salawu/tf_cloud/labs/lab12-net-ic/1-gcp-hub/5-vpc-anthos/1-vpc/terraform.tfstate"
  }
}

locals {
  vpc     = data.terraform_remote_state.vpc.outputs.vpc
  vpc_nic = data.terraform_remote_state.vpc_nic.outputs.network.vpc_anthos
  subnet  = data.terraform_remote_state.vpc.outputs.subnet
}
