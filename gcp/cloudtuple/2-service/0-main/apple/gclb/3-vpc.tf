# gclb global static ip address
#--------------------------------------
resource "google_compute_global_address" "ipv4" {
  name        = "${var.main}ipv4"
  description = "static ipv4 address for gclb frontend"
}

resource "google_compute_global_address" "ipv6" {
  name        = "${var.main}ipv6"
  description = "static ipv6 address for gclb frontend"
  ip_version  = "IPV6"
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

# GFE LB IP ranges
# ======================
data "google_compute_lb_ip_ranges" "ranges" {}

output "nlb_ip_ranges" {
  value = "${data.google_compute_lb_ip_ranges.ranges.network}"
}

output "gclb_ip_ranges" {
  value = "${data.google_compute_lb_ip_ranges.ranges.http_ssl_tcp_internal}"
}

# netblock
# ======================
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

