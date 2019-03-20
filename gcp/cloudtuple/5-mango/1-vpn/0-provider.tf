provider "google" {
  project    = "${var.project_name}"
}

provider "google-beta" {
  project    = "${var.project_name}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/5-mango/1-vpn"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/5-mango/0-vpc"
  }
}

# remote state files for host project data
data "terraform_remote_state" "host" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/1-host/0-main/0-vpc"
  }
}

# AWS remote state
data "terraform_remote_state" "aws" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/aws/cloudtuple/1-vpc/us-e1/vpc1"
  }
}
