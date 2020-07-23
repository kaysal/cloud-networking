
provider "google" {
  project = var.project_id_hub
}

provider "google-beta" {
  project = var.project_id_hub
}

data "terraform_remote_state" "org" {
  backend = "gcs"

  config = {
    bucket = "tf-ongcp"
    prefix = "states/gcp/ongcp/0-org/salawu"
  }
}

provider "random" {}

locals {
  hub = {
    project = data.terraform_remote_state.org.outputs.org.hub.project
    sa      = data.terraform_remote_state.org.outputs.org.hub.service_account
  }
  spoke1 = {
    project = data.terraform_remote_state.org.outputs.org.spoke1.project
    sa      = data.terraform_remote_state.org.outputs.org.spoke1.service_account
  }
  spoke2 = {
    project = data.terraform_remote_state.org.outputs.org.spoke2.project
    sa      = data.terraform_remote_state.org.outputs.org.spoke2.service_account
  }
}

locals {
  prefix_untrust = "${var.global.prefix}${var.hub.prefix}untrust-"
  prefix_trust1  = "${var.global.prefix}${var.hub.prefix}trust1-"
  prefix_trust2  = "${var.global.prefix}${var.hub.prefix}trust2-"
}
