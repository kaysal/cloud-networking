
provider "google" {
  project = var.project_id_hub
}

provider "google-beta" {
  project = var.project_id_hub
}

data "terraform_remote_state" "org" {
  backend = "local"

  config = {
    path = "../../../0-org/salawu/terraform.tfstate"
  }
}

provider "random" {}

locals {
  hub = {
    project         = data.terraform_remote_state.org.outputs.org.hub.project
    sa = data.terraform_remote_state.org.outputs.org.hub.service_account
  }
  spoke1 = {
    project         = data.terraform_remote_state.org.outputs.org.spoke1.project
    sa = data.terraform_remote_state.org.outputs.org.spoke1.service_account
  }
  spoke2 = {
    project         = data.terraform_remote_state.org.outputs.org.spoke2.project
    sa = data.terraform_remote_state.org.outputs.org.spoke2.service_account
  }
}
