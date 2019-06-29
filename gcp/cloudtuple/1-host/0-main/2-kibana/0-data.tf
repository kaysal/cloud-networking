# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

# vpc remote state files
data "terraform_remote_state" "vpc" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/0-main/0-vpc"
  }
}

# dns data
data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  name    = "public-host-cloudtuple"
}

data "google_compute_network" "vpc" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  name    = data.terraform_remote_state.vpc.outputs.vpc_name
}

