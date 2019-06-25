# host
#--------------------------
# org admin remote state files
data "terraform_remote_state" "host" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

# netsec
#--------------------------
data "terraform_remote_state" "netsec" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/6-netsec"
  }
}

# apple
#--------------------------
data "terraform_remote_state" "apple" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/2-apple/"
  }
}

# gke
#--------------------------
data "terraform_remote_state" "gke" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/5-gke"
  }
}

# orange
#--------------------------
data "terraform_remote_state" "orange" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/3-orange"
  }
}

data "terraform_remote_state" "orange_vpc" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/4-orange/0-vpc"
  }
}

data "google_compute_network" "orange_vpc" {
  project = data.terraform_remote_state.orange.outputs.orange_project_id
  name    = data.terraform_remote_state.orange_vpc.outputs.vpc_name
}

# mango
#--------------------------
data "terraform_remote_state" "mango" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/4-mango"
  }
}

data "terraform_remote_state" "mango_vpc" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/5-mango/0-vpc"
  }
}

data "google_compute_network" "mango_vpc" {
  project = data.terraform_remote_state.mango.outputs.mango_project_id
  name    = data.terraform_remote_state.mango_vpc.outputs.vpc_name
}

# Other data
#-----------------------------------------------
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

# GFE LB IP ranges
data "google_compute_lb_ip_ranges" "ranges" {
}

output "nlb_ip_ranges" {
  value = data.google_compute_lb_ip_ranges.ranges.network
}

output "gclb_ip_ranges" {
  value = data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal
}

# netblock
#-----------------------------------------------
data "google_netblock_ip_ranges" "netblock" {
}

/*
output "cidr_blocks" {
  value = "${data.google_netblock_ip_ranges.netblock.cidr_blocks}"
}
output "cidr_blocks_ipv4" {
  value = "${data.google_netblock_ip_ranges.netblock.cidr_blocks_ipv4}"
}
output "cidr_blocks_ipv6" {
  value = "${data.google_netblock_ip_ranges.netblock.cidr_blocks_ipv6}"
}*/
