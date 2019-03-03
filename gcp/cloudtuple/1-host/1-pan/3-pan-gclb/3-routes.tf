resource "google_compute_route" "trust_route_b" {
  name                   = "${var.name}-trust-route-b"
  dest_range             = "0.0.0.0/0"
  network                = "${data.terraform_remote_state.vpc.vpc_trust}"
  next_hop_instance_zone = "europe-west1-b"
  next_hop_instance      = "${google_compute_instance.fw_b.name}"
  priority               = 100
  tags                   = ["${var.name}"]
}

resource "google_compute_route" "trust_route_c" {
  name                   = "${var.name}-trust-route-c"
  dest_range             = "0.0.0.0/0"
  network                = "${data.terraform_remote_state.vpc.vpc_trust}"
  next_hop_instance_zone = "europe-west1-c"
  next_hop_instance      = "${google_compute_instance.fw_c.name}"
  priority               = 100
  tags                   = ["${var.name}"]
}
