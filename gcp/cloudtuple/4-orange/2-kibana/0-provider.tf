provider "google" {
  project = "${data.terraform_remote_state.orange.orange_project_id}"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.orange.orange_project_id}"
}

provider random {}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/0-main/2-kibana"
  }
}
