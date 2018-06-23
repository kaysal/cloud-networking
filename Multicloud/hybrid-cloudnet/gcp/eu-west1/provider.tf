
provider "google" {
  project     = "${var.project_name}"
  credentials = "${file("${var.credentials_file_path}")}"
  region  = "europe-west1"
}
