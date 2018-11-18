# PROVIDER
#==============================
provider "aws" {
  region     = "eu-west-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

provider "aws" {
  alias      = "us-e1"
  region     = "us-east-1"
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
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w2/vpc1"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# Existing zones created on aws console
#==============================
data "aws_route53_zone" "cloudtuples" {
  name         = "${var.domain_name}."
  private_zone = false
}

data "aws_route53_zone" "cloudtuples_private" {
  name         = "${var.domain_name}."
  vpc_id       = "${data.terraform_remote_state.w2_vpc1.vpc1}"
  private_zone = true
}
