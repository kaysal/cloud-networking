# HTTPS Load Balancer
# Regional Managed Instance groups
# Blue/Green Deployment + a Red Standalone

provider "google" {
  project    = "${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/vpcuser16/https-lb"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
