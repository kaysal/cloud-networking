provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudnet18/private-dns"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
