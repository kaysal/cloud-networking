# forwarding rule
resource "google_compute_forwarding_rule" "fwd_rule" {
  name        = "${var.name}fwd-rule"
  target      = "${google_compute_target_pool.target_pool.self_link}"
  ip_address  = "${google_compute_address.ipv4.address}"
  ip_protocol = "TCP"
  port_range  = "80"
}

# TCP IPv4 VIP
resource "google_dns_record_set" "nlb" {
  project      = "${data.terraform_remote_state.host.host_project_id}"
  managed_zone = "${data.google_dns_managed_zone.public_host_cloudtuple.name}"
  name         = "nlb.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = ["${google_compute_address.ipv4.address}"]
}
