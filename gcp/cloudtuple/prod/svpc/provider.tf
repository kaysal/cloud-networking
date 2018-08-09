
provider "google" {
  project = "${data.terraform_remote_state.prod.prod_service_project_id}"
  credentials = "${var.credentials_file_path}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/prod/svpc/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# org admin remote state files
data "terraform_remote_state" "netsec" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/1-org-admin/1-netsec/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

data "terraform_remote_state" "prod" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/1-org-admin/2-prod/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

data "terraform_remote_state" "test" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/1-org-admin/3-test/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

data "terraform_remote_state" "gke" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/1-org-admin/4-gke/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# xpn remote state files
data "terraform_remote_state" "xpn" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/2-host-xpn/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
