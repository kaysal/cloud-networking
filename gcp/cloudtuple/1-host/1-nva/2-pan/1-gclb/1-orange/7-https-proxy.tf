resource "google_compute_target_https_proxy" "https_proxy" {
  provider = "google-beta"
  name     = "${var.name}-http-proxy"
  url_map  = "${google_compute_url_map.url_map.self_link}"

  ssl_certificates = [
    "${google_compute_managed_ssl_certificate.ssl_cert.self_link}",
  ]
}
