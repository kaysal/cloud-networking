# Specify the provider and access details
provider "aws" {
  region     = "eu-west-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/aws/gcp-vpn/eu-w2-vpc1/"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/1-host/0-main-demo/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

data "terraform_remote_state" "vpcuser16" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/vpcuser16/private-dns/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
