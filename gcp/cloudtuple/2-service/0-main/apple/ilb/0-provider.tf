provider "google" {
  project     = "${data.terraform_remote_state.apple.apple_service_project_id}"
  region      = "europe-west1"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/2-service/0-main/apple/ilb"
  }
}
