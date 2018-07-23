# Specify the provider and access details
provider "aws" {
  region     = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/svpc/3-aws/us-e1-vpc1/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "xpn" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/svpc/2-gcp-host-xpn/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
