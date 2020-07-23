
# http proxy

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "${var.global.prefix}${local.prefix}http-proxy"
  url_map = google_compute_url_map.url_map.self_link
}
