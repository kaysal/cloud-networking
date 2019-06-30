provider "google" {
  project = data.terraform_remote_state.orange.outputs.orange_project_id
}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/4-orange/1-ilb"
  }
}

