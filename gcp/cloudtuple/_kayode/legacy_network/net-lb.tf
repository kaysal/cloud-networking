
resource "google_compute_target_pool" "www_pool" {
  name = "www-pool"
  session_affinity = "NONE"

  instances = [
    "europe-west1-b/www-0",
    "europe-west1-b/www-1",
  ]

  health_checks = [
    "${google_compute_http_health_check.my_health_check.name}",
  ]
}

resource "google_compute_http_health_check" "my_health_check" {
  name               = "my-health-check"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_forwarding_rule" "wwww_forwarding_rule" {
  name       = "wwww-forwarding-rule"
  target     = "${google_compute_target_pool.www_pool.self_link}"
  port_range = "80"
}
