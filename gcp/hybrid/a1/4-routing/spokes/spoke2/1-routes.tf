
resource "google_compute_route" "spoke2_private_googleapis" {
  project          = var.project_id_spoke2
  name             = "${var.global.prefix}${var.spoke2.prefix}private-googleapis"
  description      = "Route to default gateway for private.googleapis.com"
  dest_range       = "199.36.153.4/30"
  network          = local.vpc.self_link
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}

resource "google_compute_route" "spoke2_restricted_googleapis" {
  project          = var.project_id_spoke2
  name             = "${var.global.prefix}${var.spoke2.prefix}restricted-googleapis"
  description      = "Route to default gateway for restricted.googleapis.com"
  dest_range       = "199.36.153.8/30"
  network          = local.vpc.self_link
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}
