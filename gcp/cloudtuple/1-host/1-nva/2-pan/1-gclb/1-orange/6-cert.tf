resource "google_compute_managed_ssl_certificate" "ssl_cert" {
  provider = "google-beta"
  name = "${var.name}-ssl-cert"

  managed {
    domains = ["${google_dns_record_set.pan_gclb.name}"]
  }
}
