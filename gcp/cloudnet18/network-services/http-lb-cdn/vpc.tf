# gclb global static ip address
#--------------------------------------
resource "google_compute_global_address" "gclb_ipv4" {
  name = "${var.name}gclb-ipv4"
  description = "static ipv4 address for gclb frontend"
}
