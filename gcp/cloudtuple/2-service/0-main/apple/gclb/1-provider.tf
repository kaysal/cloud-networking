provider "google" {
  project = data.terraform_remote_state.apple.outputs.apple_service_project_id
}

provider "google-beta" {
  project = data.terraform_remote_state.apple.outputs.apple_service_project_id
}

provider "random" {
}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/2-service/0-main/apple/gclb"
  }
}

