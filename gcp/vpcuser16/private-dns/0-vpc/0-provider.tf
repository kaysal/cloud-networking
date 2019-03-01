provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/vpcuser16/private-dns/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
