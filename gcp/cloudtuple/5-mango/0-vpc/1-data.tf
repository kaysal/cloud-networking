# org data for mango project
data "terraform_remote_state" "mango" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/4-mango"
  }
}

# host project data
data "terraform_remote_state" "host" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "states/gcp/cloudtuple/0-org/1-host"
  }
}

# dns data
data "google_dns_managed_zone" "public_host_cloudtuple" {
  project = "${data.terraform_remote_state.host.host_project_id}"
  name    = "public-host-cloudtuple"
}

# capture local machine ipv4
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

# GFE LB IP ranges
data "google_compute_lb_ip_ranges" "ranges" {}

output "nlb_ip_ranges" {
  value = "${data.google_compute_lb_ip_ranges.ranges.network}"
}

output "gclb_ip_ranges" {
  value = "${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"
}

# netblock
data "google_netblock_ip_ranges" "netblock" {}

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
