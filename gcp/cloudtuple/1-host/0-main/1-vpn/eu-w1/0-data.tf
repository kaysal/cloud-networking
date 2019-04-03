# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/0-main/0-vpc"
  }
}

# remote state files for aws tunnel data
data "terraform_remote_state" "aws" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/eu-w1/vpc1"
  }
}

data "google_compute_network" "vpc" {
  name    = "${data.terraform_remote_state.vpc.vpc_name}"
  project = "${data.terraform_remote_state.host.host_project_id}"
}
