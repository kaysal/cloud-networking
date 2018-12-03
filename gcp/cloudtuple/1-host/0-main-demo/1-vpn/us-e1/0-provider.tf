provider "google" {
  project = "${data.terraform_remote_state.host.host_project_id}"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.host.host_project_id}"
}

terraform {
  backend "gcs" {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/1-host/0-main-demo/1-vpn/us-e1"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/0-org/1-host"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/1-host/0-main-demo/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for aws tunnel data
data "terraform_remote_state" "aws_us_e1_vpc1" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/aws/cloudtuple/1-vpc/us-e1/vpc1"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}

# remote state files for lzone2 data
data "terraform_remote_state" "lzone2" {
  backend = "gcs"
  config {
    bucket  = "tf-shk"
    prefix  = "states/gcp/cloudtuple/5-mango/lzone2/0-vpc"
    credentials ="~/tf/credentials/gcp-credentials-tf.json"
  }
}
