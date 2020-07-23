# orange 80

resource "google_compute_backend_service" "be_svc_orange_80" {
  provider = google-beta
  name     = "${var.name}-be-svc-orange-80"
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
    group = data.terraform_remote_state.pan.outputs.ig_b
  }
  backend {
    group = data.terraform_remote_state.pan.outputs.ig_c
  }
  health_checks = [google_compute_health_check.hc_80.self_link]
}

# orange 8080

resource "google_compute_backend_service" "be_svc_orange_8080" {
  provider = google-beta
  name     = "${var.name}-be-svc-orange-8080"
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
    group = data.terraform_remote_state.pan.outputs.ig_b
  }
  backend {
    group = data.terraform_remote_state.pan.outputs.ig_c
  }
  health_checks = [google_compute_health_check.hc_8080.self_link]
}

# gke 8081

resource "google_compute_backend_service" "be_svc_gke_8081" {
  provider = google-beta
  name     = "${var.name}-be-svc-gke-8081"
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
    group = data.terraform_remote_state.pan.outputs.ig_b
  }
  backend {
    group = data.terraform_remote_state.pan.outputs.ig_c
  }
  health_checks = [google_compute_health_check.hc_8081.self_link]
}

