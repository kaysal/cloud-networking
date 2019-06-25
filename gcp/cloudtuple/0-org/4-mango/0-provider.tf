provider "google" {
  // gcloud auth application-default login
}

provider "random" {
}

terraform {
  backend "gcs" {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/0-org/4-mango/"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

