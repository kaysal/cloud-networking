provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudnet18/network-services/https-lb"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

data "google_compute_region_instance_group" "natgw_mig" {
  self_link = "${google_compute_region_instance_group_manager.natgw_mig.instance_group}"
}
