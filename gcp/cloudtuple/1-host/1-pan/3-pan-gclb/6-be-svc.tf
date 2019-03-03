resource "google_compute_backend_service" "be_svc" {
  provider = "google-beta"
  name     = "${var.name}-be-svc"
  protocol = "HTTP"

  custom_request_headers = [
    "X-Client-RTT-msec:{client_rtt_msec}",
    "X-Client-Geo-Location:{client_region},{client_city}",
    "X-Client-Region-Subdivision:{client_region_subdivision}",
    "X-Client-Lat-Long:{client_city_lat_long}",
    "X-TLS-SNI-Hostname:{tls_sni_hostname}",
    "X-TLS-Version:{tls_version}",
    "X-TLS-Cipher-Suite:{tls_cipher_suite}",
  ]

  backend {
    group = "${google_compute_instance_group.instance_grp_b.self_link}"
  }

  backend {
    group = "${google_compute_instance_group.instance_grp_c.self_link}"
  }

  health_checks = ["${google_compute_health_check.health_chk.self_link}"]
}
