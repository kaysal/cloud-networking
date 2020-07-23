# url map
resource "google_compute_url_map" "url_map" {
  name            = "${var.name}url-map"
  default_service = google_compute_backend_service.be_svc.self_link

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_service.be_svc.self_link
  }
}
