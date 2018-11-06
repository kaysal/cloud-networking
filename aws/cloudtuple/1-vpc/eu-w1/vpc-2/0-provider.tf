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
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w1/vpc-2"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# REMOTE STATES
#==============================
# eu-west1 vpc1 remote state files
data "terraform_remote_state" "w1_vpc1" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w1/vpc-1"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}
