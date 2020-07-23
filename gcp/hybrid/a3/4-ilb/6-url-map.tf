
# url map

resource "google_compute_region_url_map" "url_map" {
  provider        = google-beta
  name            = "${var.global.prefix}${local.prefix}url-map"
  region          = var.gcp.region
  default_service = google_compute_region_backend_service.bes.self_link

  host_rule {
    hosts        = ["ilb.cloudtuple.com"]
    path_matcher = "ilb"
  }

  path_matcher {
    name            = "ilb"
    default_service = google_compute_region_backend_service.bes.self_link
  }
}
