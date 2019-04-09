provider "google" {
  project = "${data.terraform_remote_state.gke.gke_service_project_id}"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.gke.gke_service_project_id}"
}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/2-service/0-main/gke/clust-w1"
  }
}
