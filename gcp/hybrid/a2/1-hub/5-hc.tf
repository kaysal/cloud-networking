
resource "google_compute_health_check" "hc_8080" {
  name = "${var.global.prefix}${var.hub.prefix}hc-8080"

  http_health_check {
    port = 8080
  }
}

resource "google_compute_health_check" "hc_8081" {
  name = "${var.global.prefix}${var.hub.prefix}hc-8081"

  http_health_check {
    port = 8081
  }
}
