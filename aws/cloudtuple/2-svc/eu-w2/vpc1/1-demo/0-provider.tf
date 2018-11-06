# PROVIDER
#==============================
provider "aws" {
  region     = "eu-west-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

provider "random" {}

# BACKEND
#==============================
terraform {
  backend "gcs" {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/2-svc/eu-w2/vpc1/1-demo"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# REMOTE STATES
#==============================
# eu-west1 vpc remote state files
data "terraform_remote_state" "w2_vpc1" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w2/vpc-1"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}
