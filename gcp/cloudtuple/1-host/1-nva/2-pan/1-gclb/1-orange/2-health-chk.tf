resource "google_compute_health_check" "hc_80" {
  name = "${var.name}-hc-80"

  http_health_check {
    host         = "google-hc-80"
    port         = 80
    request_path = "/app80/"
  }
}

resource "google_compute_health_check" "hc_8080" {
  name = "${var.name}-hc-8080"

  http_health_check {
    host         = "google-hc-8080"
    port         = 8080
    request_path = "/app8080/"
  }
}

resource "google_compute_health_check" "hc_8081" {
  name = "${var.name}-hc-8081"

  http_health_check {
    host         = "google-hc-8081"
    port         = 8081
    request_path = "/"
  }
}
