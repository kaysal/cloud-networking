# PROVIDER
#==============================
provider "aws" {
  region     = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  version    = "~> 2.2"
}

provider "random" {}

# BACKEND
#==============================
terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/us-e1/vpc1"
  }
}
