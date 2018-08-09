# Specify the provider and access details
provider "aws" {
  region     = "eu-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/aws/gcp-vpn/eu-w1-vpc1/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for IAM
data "terraform_remote_state" "xpn" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/base/2-host-xpn/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
