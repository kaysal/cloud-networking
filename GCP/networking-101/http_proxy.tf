# Create healthcheck
#---------------------------------------
resource "google_compute_health_check" "my_http_hc" {
  name = "my-http-hc"
  http_health_check {
    port = "80"
  }
  check_interval_sec = "5"
  timeout_sec = "5"
  healthy_threshold = "2"
  unhealthy_threshold = "2"
}

# Create backend service
#---------------------------------------
resource "google_compute_backend_service" "my_backend_service" {
  name     = "my-backend-service"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = "30"
  backend {
    group = "${google_compute_region_instance_group_manager.us_east1_mig.instance_group}"
    balancing_mode = "RATE"
    max_rate_per_instance = "50"
    capacity_scaler = "1"
  }
  backend {
    group = "${google_compute_region_instance_group_manager.europe_west1_mig.instance_group}"
    balancing_mode = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }
  health_checks = ["${google_compute_health_check.my_http_hc.self_link}"]
}

# Create http proxy frontend
#---------------------------------------

resource "google_compute_url_map" "my_gclb" {
  name = "my-gclb"
  default_service = "${google_compute_backend_service.my_backend_service.self_link}"
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  description = "gclb http proxy"
  url_map = "${google_compute_url_map.my_gclb.self_link}"
}

resource "google_compute_global_forwarding_rule" "nw101_forwarding_rule" {
  name       = "nw101-forwarding-rule"
  target     = "${google_compute_target_http_proxy.http_proxy.self_link}"
  ip_protocol = "TCP"
  port_range = "80"
}
