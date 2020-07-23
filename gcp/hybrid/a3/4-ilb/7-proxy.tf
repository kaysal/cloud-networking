
# http proxy

resource "google_compute_region_target_http_proxy" "http_proxy" {
  provider = google-beta
  name     = "${var.global.prefix}${local.prefix}http-proxy"
  region   = var.gcp.region
  url_map  = google_compute_region_url_map.url_map.id
}
