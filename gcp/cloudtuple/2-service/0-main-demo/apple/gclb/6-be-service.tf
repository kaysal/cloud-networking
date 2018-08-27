# backend service
#---------------------------------------
resource "google_compute_backend_service" "prod_backend_service" {
  name     = "${var.name}prod-backend-service"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = "30"
  #enable_cdn  = true
  security_policy = "${google_compute_security_policy.prod_app_policy.name}"

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
    group = "${google_compute_region_instance_group_manager.blue_eu_w1.instance_group}"
    balancing_mode = "RATE"
    max_rate_per_instance = "50"
    capacity_scaler = "1"
  }

  backend {
    group = "${google_compute_region_instance_group_manager.blue_eu_w2.instance_group}"
    balancing_mode = "RATE"
    max_rate_per_instance = "50"
    capacity_scaler = "1"
  }

  backend {
    group = "${google_compute_region_instance_group_manager.green_eu_w1.instance_group}"
    balancing_mode = "RATE"
    max_rate_per_instance = "50"
    capacity_scaler = "0"
  }

  backend {
    group = "${google_compute_region_instance_group_manager.green_eu_w2.instance_group}"
    balancing_mode = "RATE"
    max_rate_per_instance = "50"
    capacity_scaler = "0"
  }

  health_checks = ["${google_compute_health_check.http_hc.self_link}"]
}

resource "google_compute_backend_service" "dev_backend_service" {
  name     = "${var.name}dev-backend-service"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = "30"
  enable_cdn  = true
  #security_policy = "${google_compute_security_policy.dev_app_policy.name}"

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
    group = "${google_compute_region_instance_group_manager.dev_us_e1.instance_group}"
    balancing_mode = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }

  health_checks = ["${google_compute_health_check.http_hc.self_link}"]
}
