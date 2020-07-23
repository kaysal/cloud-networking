
# url map

resource "google_compute_url_map" "url_map" {
  name            = "${var.global.prefix}${local.prefix}url-map"
  default_service = google_compute_backend_service.bes.self_link

  host_rule {
    hosts        = ["web.cloudtuple.com"]
    path_matcher = "web"
  }

  path_matcher {
    name            = "web"
    default_service = google_compute_backend_service.bes.self_link
  }
}
