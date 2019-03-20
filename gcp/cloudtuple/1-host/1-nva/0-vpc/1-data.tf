# org admin remote state files
#--------------------------------------
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
    prefix = "states/gcp/cloudtuple/0-org/2-apple/"
  }
}

# capture local machine ipv4 to use in security configuration
#--------------------------------------
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}

# GFE LB IP ranges
#--------------------------------------
data "google_compute_lb_ip_ranges" "ranges" {}

output "nlb_ip_ranges" {
  value = "${data.google_compute_lb_ip_ranges.ranges.network}"
}

output "gclb_ip_ranges" {
  value = "${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"
}

# netblock
#--------------------------------------
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
