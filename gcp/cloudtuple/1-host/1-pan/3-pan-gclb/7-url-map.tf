resource "google_compute_url_map" "url_map" {
  name            = "${var.name}-url-map"
  default_service = "${google_compute_backend_service.be_svc.self_link}"
}
