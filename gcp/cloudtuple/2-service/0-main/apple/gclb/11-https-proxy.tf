# https proxy frontend
resource "google_compute_target_https_proxy" "https_proxy" {
  name    = "${var.name}https-proxy"
  url_map = "${google_compute_url_map.url_map.self_link}"

  ssl_certificates = [
    "${google_compute_ssl_certificate.prod_cert.self_link}",
    "${google_compute_ssl_certificate.dev_cert.self_link}",
  ]

  ssl_policy = "${google_compute_ssl_policy.ssl_policy_modern.self_link}"
}

# ssl policy
resource "google_compute_ssl_policy" "ssl_policy_modern" {
  name            = "${var.name}ssl-policy-modern"
  profile         = "MODERN"
  min_tls_version = "TLS_1_2"
}
