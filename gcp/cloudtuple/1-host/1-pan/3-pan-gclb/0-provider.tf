provider "google" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  zone    = "${var.region_zone}"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  zone    = "${var.region_zone}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/1-pan/3-pan-gclb"
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
