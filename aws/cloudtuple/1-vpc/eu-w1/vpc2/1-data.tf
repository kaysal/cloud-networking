# REMOTE STATES
#==============================
# eu-west1 Regional shared stuff
data "terraform_remote_state" "w1_shared" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/eu-w1/shared"
  }
}

# eu-west1 vpc1 remote state files
data "terraform_remote_state" "w1_vpc1" {
  backend = "gcs"

  config = {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w1/vpc1"
    credentials = "~/tf/credentials/gcp-credentials-tf.json"
  }
}

# eu-west1 vpc2 remote state files
data "terraform_remote_state" "w1_vpc2" {
  backend = "gcs"

  config = {
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

