
resource "google_compute_route" "private_googleapis" {
  project          = var.project_id_spoke1
  name             = "${var.global.prefix}private-googleapis"
  description      = "Route to default gateway for private.googleapis.com"
  dest_range       = "199.36.153.4/30"
  network          = google_compute_network.spoke1.self_link
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

resource "google_compute_route" "restricted_googleapis" {
  project          = var.project_id_spoke1
  name             = "${var.global.prefix}restricted-googleapis"
  description      = "Route to default gateway for restricted.googleapis.com"
  dest_range       = "199.36.153.8/30"
  network          = google_compute_network.spoke1.self_link
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}
