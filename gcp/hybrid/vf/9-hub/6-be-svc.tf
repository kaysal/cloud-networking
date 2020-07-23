
# spoke1 services

resource "google_compute_region_backend_service" "spoke1_8080" {
  name             = "${var.global.prefix}${var.hub.prefix}spoke1-8080"
  region           = var.hub.region.eu1
  protocol         = "TCP"
  session_affinity = "CLIENT_IP"

  backend { group = google_compute_instance_group.eu1_ig_b.self_link }
  backend { group = google_compute_instance_group.eu1_ig_c.self_link }

  health_checks = [google_compute_health_check.hc_8080.self_link]
}

resource "google_compute_region_backend_service" "spoke1_8081" {
  name             = "${var.global.prefix}${var.hub.prefix}spoke1-8081"
  region           = var.hub.region.eu1
  protocol         = "TCP"
  session_affinity = "CLIENT_IP"

  backend { group = google_compute_instance_group.eu1_ig_b.self_link }
  backend { group = google_compute_instance_group.eu1_ig_c.self_link }

  health_checks = [google_compute_health_check.hc_8081.self_link]
}

# spoke2 services

resource "google_compute_region_backend_service" "spoke2_8080" {
  name             = "${var.global.prefix}${var.hub.prefix}spoke2-8080"
  region           = var.hub.region.eu2
  protocol         = "TCP"
  session_affinity = "CLIENT_IP"

  backend { group = google_compute_instance_group.eu2_ig_b.self_link }
  backend { group = google_compute_instance_group.eu2_ig_c.self_link }

  health_checks = [google_compute_health_check.hc_8080.self_link]
}

resource "google_compute_region_backend_service" "spoke2_8081" {
  name             = "${var.global.prefix}${var.hub.prefix}spoke2-8081"
  region           = var.hub.region.eu2
  protocol         = "TCP"
  session_affinity = "CLIENT_IP"

  backend { group = google_compute_instance_group.eu2_ig_b.self_link }
  backend { group = google_compute_instance_group.eu2_ig_c.self_link }

  health_checks = [google_compute_health_check.hc_8081.self_link]
}
