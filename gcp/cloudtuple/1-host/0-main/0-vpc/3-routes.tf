resource "google_compute_route" "private_googleapis" {
  name             = "${var.env}private-googleapis"
  description      = "Route to default gateway for PGA"
  dest_range       = "199.36.153.4/30"
  network          = "${google_compute_network.vpc.name}"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000

  lifecycle {
    ignore_changes = "all"
  }
}
