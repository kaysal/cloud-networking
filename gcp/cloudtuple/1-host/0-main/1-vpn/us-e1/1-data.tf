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

# remote state files for aws tunnel data
data "terraform_remote_state" "aws_us_e1_vpc1" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/aws/cloudtuple/1-vpc/us-e1/vpc1"
  }
}

# remote state files for lzone2 data
data "terraform_remote_state" "lzone2" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/5-mango/lzone2/0-vpc"
  }
}

data "google_compute_network" "vpc" {
  name = data.terraform_remote_state.vpc.outputs.vpc_name
}

data "google_compute_address" "vpn_gw1_ip_us_e1" {
  name   = data.terraform_remote_state.vpc.outputs.vpn_gw1_ip_us_e1_name
  region = "us-east1"
}

data "google_compute_address" "vpn_gw2_ip_us_e1" {
  name   = data.terraform_remote_state.vpc.outputs.vpn_gw2_ip_us_e1_name
  region = "us-east1"
}

