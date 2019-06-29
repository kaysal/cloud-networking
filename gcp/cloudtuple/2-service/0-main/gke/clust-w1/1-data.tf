# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

data "terraform_remote_state" "gke" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/5-gke"
  }
}

data "terraform_remote_state" "apple" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/2-apple/"
  }
}

data "terraform_remote_state" "orange" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/3-orange"
  }
}

data "terraform_remote_state" "mango" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/4-mango"
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

data "google_compute_network" "vpc" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  name    = data.terraform_remote_state.vpc.outputs.vpc_name
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}
