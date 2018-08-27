# backend service
#---------------------------------------
resource "google_compute_backend_service" "prod_backend" {
  name     = "${var.name}prod-backend"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = "30"
  custom_request_headers = [
    "X-Client-Geo-Location:{client_region},{client_city}",
    "X-TLS:{tls_sni_hostname},{tls_version},{tls_cipher_suite}"
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
    "X-Client-Geo-Location:{client_region},{client_city}",
    "X-TLS:{tls_sni_hostname},{tls_version},{tls_cipher_suite}"
  ]


  backend {
    group = "${google_compute_region_instance_group_manager.natgw_mig.instance_group}"
    balancing_mode = "UTILIZATION"
    max_utilization = "0.8"
    capacity_scaler = "1"
  }

  health_checks = ["${google_compute_health_check.dev_http_hc.self_link}"]
}

# url map
resource "google_compute_url_map" "gclb" {
  name            = "${var.name}gclb"
  default_service = "${google_compute_backend_service.prod_backend.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  host_rule {
    hosts        = ["dev.gcpdemo.cloudtuple.com"]
    path_matcher = "devpath"
  }

  host_rule {
    hosts        = ["prod.gcpdemo.cloudtuple.com"]
    path_matcher = "prodpath"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.prod_backend.self_link}"
  }

  path_matcher {
    name            = "devpath"
    default_service = "${google_compute_backend_service.dev_backend.self_link}"
  }

  path_matcher {
    name            = "prodpath"
    default_service = "${google_compute_backend_service.prod_backend.self_link}"
  }
}

# https proxy frontend
resource "google_compute_target_https_proxy" "https_proxy" {
  name             = "${var.name}https-proxy"
  url_map          = "${google_compute_url_map.gclb.self_link}"
  ssl_certificates = [
    "${google_compute_ssl_certificate.dev_gcpdemo_solutions.self_link}",
    "${google_compute_ssl_certificate.prod_gcpdemo_solutions.self_link}"
  ]
  ssl_policy = "${google_compute_ssl_policy.gcpdemo_sp_modern.self_link}"
}

resource "google_compute_global_forwarding_rule" "gclb_v4" {
  name       = "${var.name}gclb-v4"
  target     = "${google_compute_target_https_proxy.https_proxy.self_link}"
  ip_address = "${google_compute_global_address.gclb_ipv4.address}"
  ip_protocol = "TCP"
  port_range = "443"
}

resource "google_compute_global_forwarding_rule" "gclb_v6" {
  name       = "${var.name}gclb-v6"
  target     = "${google_compute_target_https_proxy.https_proxy.self_link}"
  ip_address = "${google_compute_global_address.gclb_ipv6.address}"
  ip_protocol = "TCP"
  port_range = "443"
}

# ssl policy
resource "google_compute_ssl_policy" "gcpdemo_sp_modern" {
  name    = "${var.name}gcpdemo-sp-modern"
  profile = "MODERN"
  min_tls_version = "TLS_1_2"
}
