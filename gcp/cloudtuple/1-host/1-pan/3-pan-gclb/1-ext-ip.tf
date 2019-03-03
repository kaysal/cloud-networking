# LB address targetting PAN instance group
#--------------------------------------
resource "google_compute_global_address" "ext_ip" {
  name = "${var.name}ext-ip"
}
