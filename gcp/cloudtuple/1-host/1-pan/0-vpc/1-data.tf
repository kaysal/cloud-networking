
# capture local machine ipv4 to use in security configuration
#--------------------------------------
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}

# GFE LB IP ranges
# ======================
data "google_compute_lb_ip_ranges" "ranges" {}

output "google_compute_lb_ip_ranges" {
  value = "${data.google_compute_lb_ip_ranges.ranges.network}"
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
