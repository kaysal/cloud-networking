provider "google" {
  project = "${data.terraform_remote_state.orange.orange_project_id}"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.orange.orange_project_id}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/4-orange/0-vpc"
  }
}
