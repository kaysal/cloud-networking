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

# remote state files for mango project
data "terraform_remote_state" "mango" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/5-mango/0-vpc"
  }
}

data "google_compute_network" "vpc" {
  name    = "${data.terraform_remote_state.vpc.vpc_name}"
  project = "${data.terraform_remote_state.host.host_project_id}"
}

data "google_compute_address" "vpn_gw_ip_eu_w2" {
  name    = "${data.terraform_remote_state.vpc.vpn_gw_ip_eu_w2}"
  project = "${data.terraform_remote_state.host.host_project_id}"
  region  = "europe-west2"
}
