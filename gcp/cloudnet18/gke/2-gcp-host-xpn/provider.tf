
provider "google" {
  project    = "${data.terraform_remote_state.iam.host_project_id}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudnet18/gke/2-gcp-host-xpn"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "iam" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudnet18/gke/1-gcp-org-iam"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
