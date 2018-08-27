# https://cloud.google.com/load-balancing/docs/network/setting-up-network

provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
  region = "europe-west1"
}
