provider "google" {
  project = data.terraform_remote_state.mango.outputs.mango_project_id
}

provider "google-beta" {
  project = data.terraform_remote_state.mango.outputs.mango_project_id
}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/5-mango/1-vpn"
  }
}

