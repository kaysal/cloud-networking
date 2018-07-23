provider "google" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/svpc/1-gcp-org-iam/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
