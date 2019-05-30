provider "google" {
  project = "${data.terraform_remote_state.apple.apple_service_project_id}"
  region  = "europe-west1"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.apple.apple_service_project_id}"
  region  = "europe-west1"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/2-service/0-main/apple/nlb"
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

data "terraform_remote_state" "apple" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/2-apple"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/0-main/0-vpc"
  }
}
