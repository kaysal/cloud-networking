# orange
#--------------------------
# org data
data "terraform_remote_state" "orange" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/3-orange"
  }
}

# mango
#--------------------------
# mango org
data "terraform_remote_state" "mango" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/4-mango"
  }
}

# mango vpc
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

# host
#--------------------------
# host org
data "terraform_remote_state" "host" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

# host vpc
data "terraform_remote_state" "host_vpc" {
  backend = "gcs"

  config = {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/1-host/0-main/0-vpc"
  }
}

data "google_compute_network" "host_vpc" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  name    = data.terraform_remote_state.host_vpc.outputs.vpc_name
}

# host public dns zone
data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = data.terraform_remote_state.host.outputs.host_project_id
  name    = "public-host-cloudtuple"
}

# Other data
#--------------------------
# capture local machine ipv4
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

#  gfe ip ranges
data "google_compute_lb_ip_ranges" "ranges" {
}

output "nlb" {
  value = data.google_compute_lb_ip_ranges.ranges.network
}

output "http_ssl_tcp_internal" {
  value = data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal
}

