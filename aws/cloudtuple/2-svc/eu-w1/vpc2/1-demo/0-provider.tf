# PROVIDER
#==============================
provider "aws" {
  region     = "eu-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
  profile = "with-mfa"
  assume_role {
    role_arn = "arn:aws:iam::966891400085:mfa/salawu@google.com"
  }
}

provider "random" {
}

# BACKEND
#==============================
terraform {
  backend "gcs" {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/2-svc/eu-w1/vpc2/1-demo"
  }
}
