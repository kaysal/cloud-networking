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
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w1/vpc2"
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
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w1/vpc1"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# eu-west1 vpc2 remote state files
data "terraform_remote_state" "w1_vpc2" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w2/vpc1"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# EXTERNAL DATA
#==============================
# capture local machine ipv4 to use in sec groups etc.
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}
