provider "google" {
  project = data.terraform_remote_state.host.outputs.host_project_id
}

provider "google-beta" {
  project = data.terraform_remote_state.host.outputs.host_project_id
}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/0-main/1-vpn/eu-w1"
  }
}
