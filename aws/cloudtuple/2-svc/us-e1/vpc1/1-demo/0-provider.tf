# PROVIDER
#==============================
provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

/*
provider "aws" {
  alias      = "us-e1"
  region     = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}
*/

provider "random" {
}

# BACKEND
#==============================
terraform {
  backend "gcs" {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/2-svc/us-e1/vpc1/1-demo"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

