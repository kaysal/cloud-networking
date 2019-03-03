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
    prefix = "states/gcp/cloudtuple/2-service/2-pan-gclb/1-trust"
  }
}

# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/1-pan/0-vpc"
  }
}

data "terraform_remote_state" "apple" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/2-apple"
  }
}
