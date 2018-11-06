# PROVIDER
#==============================
provider "aws" {
  region     = "eu-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

provider "random" {}

# BACKEND
#==============================
terraform {
  backend "gcs" {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w1/vpc-1"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# REMOTE STATES
#==============================
# eu-west1 vpc2 remote state files
data "terraform_remote_state" "w1_vpc2" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w1/vpc-2"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# eu-west2 vpc remote state files
data "terraform_remote_state" "w2_vpc1" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w2/vpc-1"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# gcp vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/1-host/0-main-demo/0-vpc"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}
