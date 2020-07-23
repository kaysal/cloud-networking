# Internal forwarding rules.
# Separate FRs are created to allow us health check
# port 80 and 8080 separately...
# .. because the BE service can only health check a single port
# We can still chose to use ALL_PORTS instead os hard-coding ports
#---------------------------------

# untrust
#---------------------------------

# spoke1

resource "google_compute_forwarding_rule" "spoke1_8080" {
  provider              = google-beta
  name                  = "${var.global.prefix}${var.hub.prefix}spoke1-8080"
  region                = var.hub.region.eu1
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.spoke1_8080.self_link
  subnetwork            = google_compute_subnetwork.untrust1.self_link
  ip_address            = var.hub.untrust.eu1.ip.ilb80
  ip_protocol           = "TCP"
  ports                 = ["8080"]
  allow_global_access   = "true"
  service_label         = "spoke18080"
}

resource "google_compute_forwarding_rule" "spoke1_8081" {
  provider              = google-beta
  name                  = "${var.global.prefix}${var.hub.prefix}spoke1-8081"
  region                = var.hub.region.eu1
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.spoke1_8081.self_link
  subnetwork            = google_compute_subnetwork.untrust1.self_link
  ip_address            = var.hub.untrust.eu1.ip.ilb81
  ip_protocol           = "TCP"
  ports                 = ["8081"]
  allow_global_access   = "true"
  service_label         = "spoke18081"
}

# spoke2

resource "google_compute_forwarding_rule" "spoke2_8080" {
  provider              = google-beta
  name                  = "${var.global.prefix}${var.hub.prefix}spoke2-8080"
  region                = var.hub.region.eu2
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.spoke2_8080.self_link
  subnetwork            = google_compute_subnetwork.untrust2.self_link
  ip_address            = var.hub.untrust.eu2.ip.ilb80
  ip_protocol           = "TCP"
  ports                 = ["8080"]
  allow_global_access   = "true"
  service_label         = "spoke28080"
}

resource "google_compute_forwarding_rule" "spoke2_8081" {
  provider              = google-beta
  name                  = "${var.global.prefix}${var.hub.prefix}spoke2-8081"
  region                = var.hub.region.eu2
  load_balancing_scheme = "INTERNAL"
  backend_service       = google_compute_region_backend_service.spoke2_8081.self_link
  subnetwork            = google_compute_subnetwork.untrust2.self_link
  ip_address            = var.hub.untrust.eu2.ip.ilb81
  ip_protocol           = "TCP"
  ports                 = ["8081"]
  allow_global_access   = "true"
  service_label         = "spoke28081"
}

# trust
#---------------------------------
