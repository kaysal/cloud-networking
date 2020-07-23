resource "google_compute_route" "trust_route_b1" {
  name                   = "${var.name}-trust-route-b1"
  dest_range             = "0.0.0.0/1"
  network                = data.google_compute_network.host_vpc.self_link
  next_hop_instance_zone = "europe-west1-b"
  next_hop_instance      = "${google_compute_instance.fw_b.name}"
  priority               = 100
}

resource "google_compute_route" "trust_route_b2" {
  name                   = "${var.name}-trust-route-b2"
  dest_range             = "128.0.0.0/1"
  network                = data.google_compute_network.host_vpc.self_link
  next_hop_instance_zone = "europe-west1-b"
  next_hop_instance      = "${google_compute_instance.fw_b.name}"
  priority               = 100
}

resource "google_compute_route" "trust_route_c1" {
  name                   = "${var.name}-trust-route-c1"
  dest_range             = "0.0.0.0/1"
  network                = data.google_compute_network.host_vpc.self_link
  next_hop_instance_zone = "europe-west1-c"
  next_hop_instance      = "${google_compute_instance.fw_c.name}"
  priority               = 100
}

resource "google_compute_route" "trust_route_c2" {
  name                   = "${var.name}-trust-route-c2"
  dest_range             = "128.0.0.0/1"
  network                = data.google_compute_network.host_vpc.self_link
  next_hop_instance_zone = "europe-west1-c"
  next_hop_instance      = "${google_compute_instance.fw_c.name}"
  priority               = 100
}
