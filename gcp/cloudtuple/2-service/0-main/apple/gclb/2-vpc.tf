# gclb global static ip address
#--------------------------------------
resource "google_compute_global_address" "ipv4" {
  name        = "${var.name}ipv4"
  description = "static ipv4 address for gclb frontend"
}

resource "google_compute_global_address" "ipv6" {
  name        = "${var.name}ipv6"
  description = "static ipv6 address for gclb frontend"
  ip_version  = "IPV6"
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}
