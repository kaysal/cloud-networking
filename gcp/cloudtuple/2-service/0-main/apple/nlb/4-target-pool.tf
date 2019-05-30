resource "google_compute_target_pool" "target_pool" {
  name             = "${var.name}target-pool"
  session_affinity = "NONE"

  health_checks = [
    "${google_compute_http_health_check.health_check.name}",
  ]
}
