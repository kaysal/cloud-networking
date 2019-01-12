provider "google" {
  project = "${data.terraform_remote_state.host.host_project_id}"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.host.host_project_id}"
}

terraform {
  backend "gcs" {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/1-host/0-main-demo/bucket"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/0-org/1-host"
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

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/1-host/0-main-demo/0-vpc"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}
