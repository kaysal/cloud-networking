
resource "google_compute_route" "ovpn_clients" {
  name              = "${var.global.prefix}ovpn-clients"
  description       = "Route to onprem openvpn clients"
  dest_range        = "10.8.0.0/24"
  network           = local.vpc.self_link
  next_hop_instance = google_compute_instance.ovpn.self_link
  priority          = 1000

  lifecycle {
    ignore_changes = all
  }
}
