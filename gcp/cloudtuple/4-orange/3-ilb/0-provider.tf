provider "google" {
  project     = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

terraform {
  backend "gcs" {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/4-orange/3-ilb"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/4-orange/0-vpc"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

data "terraform_remote_state" "apple" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/0-org/2-apple"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

data "terraform_remote_state" "orange" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/3-orange"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

data "terraform_remote_state" "mango" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/7-mango"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
