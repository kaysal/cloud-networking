# backend service
#---------------------------------------
resource "google_compute_backend_service" "prod_backend" {
  name     = "${var.name}prod-backend"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = "30"
  custom_request_headers = [
    "X-Client-RTT-msec:{client_rtt_msec}",
    "X-Client-Geo-Location:{client_region},{client_city}",
    "X-Client-Region-Subdivision:{client_region_subdivision}",
    "X-Client-Lat-Long:{client_city_lat_long}",
    "X-TLS-SNI-Hostname:{tls_sni_hostname}",
    "X-TLS-Version:{tls_version}",
    "X-TLS-Cipher-Suite:{tls_cipher_suite}"
  ]

  backend {
    group = "${google_compute_region_instance_group_manager.natgw_mig.instance_group}"
    balancing_mode = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }

  health_checks = ["${google_compute_health_check.prod_http_hc.self_link}"]
}

resource "google_compute_backend_service" "dev_backend" {
  name     = "${var.name}dev-backend"
  port_name = "http-8080"
  protocol = "HTTP"
  timeout_sec = "30"
  custom_request_headers = [
    "X-Client-RTT-msec:{client_rtt_msec}",
    "X-Client-Geo-Location:{client_region},{client_city}",
    "X-Client-Region-Subdivision:{client_region_subdivision}",
    "X-Client-Lat-Long:{client_city_lat_long}",
    "X-TLS-SNI-Hostname:{tls_sni_hostname}",
    "X-TLS-Version:{tls_version}",
    "X-TLS-Cipher-Suite:{tls_cipher_suite}"
  ]


  backend {
    group = "${google_compute_region_instance_group_manager.natgw_mig.instance_group}"
    balancing_mode = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }

  health_checks = ["${google_compute_health_check.dev_http_hc.self_link}"]
}
