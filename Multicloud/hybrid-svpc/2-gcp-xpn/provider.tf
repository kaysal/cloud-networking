
provider "google" {
  project    = "${data.terraform_remote_state.iam.netsec_host_project_id}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/2-gcp-xpn/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "iam" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/hybrid-svpc/1-gcp-iam/"
    credentials ="~/Terraform/credentials/gcp-credentials-tf.json"
  }
}
