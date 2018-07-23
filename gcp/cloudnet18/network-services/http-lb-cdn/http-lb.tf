# backend bucket service
resource "google_compute_backend_bucket" "cdn_backend" {
  name        = "${var.name}cdn-backend"
  description = "contains cdn image"
  bucket_name = "${google_storage_bucket.cdn_bucket.name}"
  enable_cdn  = true
}

# url map
resource "google_compute_url_map" "cdn_gclb" {
  name            = "${var.name}cdn-gclb"
  default_service = "${google_compute_backend_bucket.cdn_backend.self_link}"
}

# http proxy frontend
resource "google_compute_target_http_proxy" "http_proxy" {
  name             = "${var.name}http-proxy"
  url_map          = "${google_compute_url_map.cdn_gclb.self_link}"
}

resource "google_compute_global_forwarding_rule" "gclb_v4" {
  name       = "${var.name}gclb-v4"
  target     = "${google_compute_target_http_proxy.http_proxy.self_link}"
  ip_address = "${google_compute_global_address.gclb_ipv4.address}"
  ip_protocol = "TCP"
  port_range = "80"
}
