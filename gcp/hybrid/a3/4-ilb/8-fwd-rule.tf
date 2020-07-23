
# forwarding rule

resource "google_compute_forwarding_rule" "fr" {
  provider = google-beta
  name     = "${var.global.prefix}${local.prefix}fr"
  region   = var.gcp.region

  load_balancing_scheme = "INTERNAL_MANAGED"
  ip_protocol           = "TCP"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.http_proxy.self_link
  network               = local.vpc.self_link
  subnetwork            = local.subnet.ilb.self_link
  network_tier          = "PREMIUM"
}

# dns
