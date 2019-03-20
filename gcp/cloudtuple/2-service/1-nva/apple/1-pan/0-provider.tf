provider "google" {
  project = "${data.terraform_remote_state.apple.apple_service_project_id}"
  region  = "europe-west1"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.apple.apple_service_project_id}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/2-service/1-nva/apple/1-pan"
  }
}
