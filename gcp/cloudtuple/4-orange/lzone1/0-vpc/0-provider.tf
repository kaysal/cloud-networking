provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

provider "google-beta" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/4-orange/lzone1/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
