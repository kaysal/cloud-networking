
provider "google" {
  project    = "${var.name}${var.project_name}"
  credentials = "${var.credentials_file_path}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/svpc/5-gcp-service-projects/test/"
    credentials ="/home/salawu/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "iam" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/svpc/1-gcp-org-iam/"
    credentials ="/home/salawu/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for Shared VPC
data "terraform_remote_state" "xpn" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/svpc/2-gcp-host-xpn/"
    credentials ="/home/salawu/tf/credentials/gcp-credentials-tf.json"
  }
}
