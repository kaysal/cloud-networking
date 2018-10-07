# Specify the provider and access details
provider "aws" {
  region     = "eu-west-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

provider "random" {}

terraform {
  backend "gcs" {
    bucket      = "tf-shk"
    prefix      = "states/aws/CERT/associate/"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}
