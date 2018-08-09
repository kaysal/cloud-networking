provider "google" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudnet18/gke/1-gcp-org-iam"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
