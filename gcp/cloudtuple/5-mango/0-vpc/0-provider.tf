provider "google" {
  project = data.terraform_remote_state.mango.outputs.mango_project_id
}

provider "google-beta" {
  project = data.terraform_remote_state.mango.outputs.mango_project_id
  version = "~> 2.2"
}

provider "random" {
}

terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/5-mango/0-vpc"
  }
}

