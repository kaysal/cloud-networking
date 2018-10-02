# tcp proxy global static ip address
#--------------------------------------
resource "google_compute_address" "ipv4" {
  name = "${var.name}ipv4"
  description = "static ipv4 address for ILB"
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}
