

provider "google" {
  project = var.project_id_hub
}

provider "google-beta" {
  project = var.project_id_hub
}

# remote state

data "terraform_remote_state" "hub" {
  backend = "local"

  config = {
    path = "../../1-hub/terraform.tfstate"
  }
}

locals {
  vpc_untrust = data.terraform_remote_state.hub.outputs.hub.vpc.untrust
  vpc_trust1  = data.terraform_remote_state.hub.outputs.hub.vpc.trust1
  vpc_trust2  = data.terraform_remote_state.hub.outputs.hub.vpc.trust2
  vm_eu1_nva1 = data.terraform_remote_state.hub.outputs.hub.vm.eu1_nva1
  vm_eu1_nva2 = data.terraform_remote_state.hub.outputs.hub.vm.eu1_nva2
  vm_eu2_nva1 = data.terraform_remote_state.hub.outputs.hub.vm.eu2_nva1
  vm_eu2_nva2 = data.terraform_remote_state.hub.outputs.hub.vm.eu2_nva2
}
