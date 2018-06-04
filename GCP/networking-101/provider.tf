# https://codelabs.developers.google.com/codelabs/cloud-networking-101

provider "google" {
  project     = "${var.project_name}"
  credentials = "${file("${var.credentials_file_path}")}"
}
