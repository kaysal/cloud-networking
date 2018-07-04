provider "google" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/1-gcp-org-iam/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}
