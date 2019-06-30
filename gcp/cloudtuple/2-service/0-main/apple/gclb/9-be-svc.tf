# backend service
#---------------------------------------
resource "google_compute_backend_service" "prod_be_svc" {
  provider        = google-beta
  name            = "${var.main}prod-be-svc"
  port_name       = "http"
  protocol        = "HTTP"
  timeout_sec     = "30"
  enable_cdn      = false
  security_policy = google_compute_security_policy.prod_app_policy.name

  /*
                  iap {
                    oauth2_client_id="${var.oauth2_client_id}"
                    oauth2_client_secret="${var.oauth2_client_secret}"
                  }
                */
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
    group                 = google_compute_region_instance_group_manager.blue_eu_w1.instance_group
    balancing_mode        = "RATE"
    max_rate_per_instance = "50"
    capacity_scaler       = "1"
  }

  backend {
    group                 = google_compute_region_instance_group_manager.blue_eu_w2.instance_group
    balancing_mode        = "RATE"
    max_rate_per_instance = "50"
    capacity_scaler       = "1"
  }

  backend {
    group                 = google_compute_region_instance_group_manager.green_eu_w1.instance_group
    balancing_mode        = "RATE"
    max_rate_per_instance = "50"
    capacity_scaler       = "0"
  }

  backend {
    group                 = google_compute_region_instance_group_manager.green_eu_w2.instance_group
    balancing_mode        = "RATE"
    max_rate_per_instance = "50"
    capacity_scaler       = "0"
  }

  health_checks = [google_compute_health_check.http_80_hc.self_link]
}

resource "google_compute_backend_service" "dev_be_svc" {
  provider    = google-beta
  name        = "${var.main}dev-be-svc"
  port_name   = "http"
  protocol    = "HTTP"
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
    "X-TLS-Cipher-Suite:{tls_cipher_suite}",
  ]
  backend {
    group           = google_compute_region_instance_group_manager.dev_eu_w3.instance_group
    balancing_mode  = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }
  health_checks = [google_compute_health_check.http_80_hc.self_link]
}

/*
locals {
  app1_eu_w3a="https://www.googleapis.com/compute/beta/projects/${data.terraform_remote_state.apple.apple_service_project_id}/zones/europe-west3-a/networkEndpointGroups/${google_compute_network_endpoint_group.app1_eu_w3a.name}"
}

resource "google_compute_backend_service" "dev_neg_app1_be_svc" {
  provider    = "google-beta"
  name        = "${var.main}dev-neg-app1-be-svc"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = "30"
  enable_cdn  = false

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
    group           = "${local.app1_eu_w3a}"
    balancing_mode        = "RATE"
    max_rate_per_instance = "50"
  }
  health_checks = ["${google_compute_health_check.http_80_hc.self_link}"]
}*/
