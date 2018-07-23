# backend service
#---------------------------------------
resource "google_compute_backend_service" "prod_backend" {
  name     = "${var.name}prod-backend"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = "30"

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

# http proxy frontend
resource "google_compute_target_http_proxy" "http_proxy" {
  name             = "${var.name}http-proxy"
  url_map          = "${google_compute_url_map.gclb.self_link}"
}

resource "google_compute_global_forwarding_rule" "gclb_v4" {
  name       = "${var.name}gclb-v4"
  target     = "${google_compute_target_http_proxy.http_proxy.self_link}"
  ip_address = "${google_compute_global_address.gclb_ipv4.address}"
  ip_protocol = "TCP"
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "gclb_v6" {
  name       = "${var.name}gclb-v6"
  target     = "${google_compute_target_http_proxy.http_proxy.self_link}"
  ip_address = "${google_compute_global_address.gclb_ipv6.address}"
  ip_protocol = "TCP"
  port_range = "80"
}
