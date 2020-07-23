# http health checks
resource "google_compute_health_check" "http_80_hc" {
  name = "${var.main}http-80-hc"

  http_health_check {
    port = "80"
  }

  check_interval_sec  = "5"
  timeout_sec         = "5"
  healthy_threshold   = "2"
  unhealthy_threshold = "2"
}

/*
resource "google_compute_health_check" "http_8080_hc" {
  name = "${var.main}http-8080-hc"

  http_health_check {
    port = "8080"
  }

  check_interval_sec  = "5"
  timeout_sec         = "5"
  healthy_threshold   = "2"
  unhealthy_threshold = "2"
}*/

resource "google_compute_health_check" "app1_neg_hc" {
  provider = google-beta
  name     = "${var.main}app1-neg-hc"

  http_health_check {
    port = "80"
  }

  check_interval_sec  = "5"
  timeout_sec         = "5"
  healthy_threshold   = "2"
  unhealthy_threshold = "2"
}

resource "google_compute_health_check" "app2_neg_hc" {
  provider = google-beta
  name     = "${var.main}app2-neg-hc"

  http_health_check {
    port = "8080"
  }

  check_interval_sec  = "5"
  timeout_sec         = "5"
  healthy_threshold   = "2"
  unhealthy_threshold = "2"
}
