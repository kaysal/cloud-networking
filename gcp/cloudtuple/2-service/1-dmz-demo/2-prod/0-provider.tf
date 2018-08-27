provider "google" {
  project = "${data.terraform_remote_state.prod.prod_service_project_id}"
  credentials = "${var.credentials_file_path}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/2-service/1-dmz-demo/2-prod"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/1-host"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

data "terraform_remote_state" "prod" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/5-prod"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}


  # vpc remote state files
  data "terraform_remote_state" "vpc" {
    backend = "gcs"
    config {
      bucket  = "tf-shk"
      prefix  = "states/gcp/cloudtuple/1-host/1-dmz-demo/0-vpc"
      credentials ="~/tf/credentials/gcp-credentials-tf.json"
    }
  }
