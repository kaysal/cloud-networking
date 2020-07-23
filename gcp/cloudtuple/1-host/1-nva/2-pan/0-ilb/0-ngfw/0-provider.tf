provider "google" {
  project = data.terraform_remote_state.host.outputs.host_project_id
}

provider "google-beta" {
  project = data.terraform_remote_state.host.outputs.host_project_id
}

provider "random" {
}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/1-nva/2-pan/0-ilb/0-ngfw"
  }
}

