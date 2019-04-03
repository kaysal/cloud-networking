# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/5-mango/0-vpc"
  }
}

# remote state files for host project data
data "terraform_remote_state" "host" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/0-main/0-vpc"
  }
}

data "terraform_remote_state" "mango" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/4-mango"
  }
}

# AWS remote state
data "terraform_remote_state" "aws" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/us-e1/vpc1"
  }
}

data "google_compute_network" "vpc" {
  name    = "${data.terraform_remote_state.vpc.vpc_name}"
  project = "${data.terraform_remote_state.mango.mango_project_id}"
}
