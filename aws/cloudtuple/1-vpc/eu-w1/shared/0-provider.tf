# PROVIDER
#==============================
provider "aws" {
  region                  = "eu-west-1"
  #shared_credentials_file = "home/salawu/.aws/credentials"
  #profile                 = "evil-mfa"
}

provider "random" {}
/*
# BACKEND
#==============================
terraform {
  backend "gcs" {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/eu-w1/shared"
  }
}
*/
