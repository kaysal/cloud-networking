provider "google" {
  project = "${data.terraform_remote_state.host.host_project_id}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/1-host/1-dmz-demo/1-natgw"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/1-host"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/1-host/1-dmz-demo/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}