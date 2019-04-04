# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

data "terraform_remote_state" "apple" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/2-apple"
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

# tcp proxy global static ip address
#--------------------------------------
# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

data "google_compute_network" "vpc" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "${data.terraform_remote_state.vpc.vpc_name}"
}

data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "public-host-cloudtuple"
}

data "google_dns_managed_zone" "private_apple_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "private-apple-cloudtuple"
}
