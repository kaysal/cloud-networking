resource "google_compute_health_check" "hc_80" {
  name = "${var.name}hc-80"

  http_health_check {
    port         = 80
    request_path = "/app80/"
  }
}

resource "google_compute_health_check" "hc_8080" {
  name = "${var.name}hc-8080"

  http_health_check {
    port         = 8080
    request_path = "/app8080/"
  }
}

