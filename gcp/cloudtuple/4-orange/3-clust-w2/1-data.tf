# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/4-orange/0-vpc"
  }
}

# orange org remote state

data "terraform_remote_state" "orange" {
  backend = "gcs"
  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/3-orange"
  }
}

data "google_compute_network" "vpc" {
  project = data.terraform_remote_state.orange.outputs.orange_project_id
  name    = data.terraform_remote_state.vpc.outputs.vpc_name
}
