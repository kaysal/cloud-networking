provider "google" {
  project = "${data.terraform_remote_state.host.host_project_id}"
}

provider "google-beta" {
  project = "${data.terraform_remote_state.host.host_project_id}"
}

terraform {
  backend "gcs" {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/1-host/1-pan/1-vpn/eu-w1"
  }
}

# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/0-org/1-host"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/1-host/0-main/0-vpc"
  }
}

# vpc remote state files
data "terraform_remote_state" "untrust" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/gcp/cloudtuple/1-host/1-pan/0-vpc"
  }
}

# remote state files for aws tunnel data
data "terraform_remote_state" "aws_eu_w1_vpc1" {
  backend = "gcs"

  config {
    bucket      = "tf-shk"
    prefix      = "states/aws/cloudtuple/1-vpc/eu-w1/vpc1"
  }
}
