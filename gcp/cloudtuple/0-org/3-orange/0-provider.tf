provider "google" {
  // gcloud auth application-default login
}

provider random {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/3-orange/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
