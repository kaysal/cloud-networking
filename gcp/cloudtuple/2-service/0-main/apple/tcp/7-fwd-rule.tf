# forwarding rule
resource "google_compute_global_forwarding_rule" "fwd_rule_v4" {
  name        = "${var.name}fwd-rule-v4"
  target      = google_compute_target_tcp_proxy.tcp_proxy.self_link
  ip_address  = google_compute_global_address.ipv4.address
  ip_protocol = "TCP"
  port_range  = "110"
}

resource "google_compute_global_forwarding_rule" "fwd_rule_v6" {
  name        = "${var.name}fwd-rule-v6"
  target      = google_compute_target_tcp_proxy.tcp_proxy.self_link
  ip_address  = google_compute_global_address.ipv6.address
  ip_protocol = "TCP"
  port_range  = "110"
}

# TCP IPv4 VIP
resource "google_dns_record_set" "tcp" {
  project      = data.terraform_remote_state.host.outputs.host_project_id
  managed_zone = data.google_dns_managed_zone.public_host_cloudtuple.name
  name         = "tcp.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "A"
  ttl          = 300
  rrdatas      = [google_compute_global_address.ipv4.address]
}

# TCP IPv6 VIP
resource "google_dns_record_set" "tcp6" {
  project      = data.terraform_remote_state.host.outputs.host_project_id
  managed_zone = data.google_dns_managed_zone.public_host_cloudtuple.name
  name         = "tcp6.${data.google_dns_managed_zone.public_host_cloudtuple.dns_name}"
  type         = "AAAA"
  ttl          = 300
  rrdatas      = [google_compute_global_address.ipv6.address]
}

