provider "google" {
  // gcloud auth application-default login
}

provider random {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/1-org-admin/4-gke/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
