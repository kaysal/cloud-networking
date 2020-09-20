
# cloud router

resource "google_compute_router" "megaport_router" {
  project = var.project_id
  name    = "${var.hub.vpc1.prefix}megaport-router"
  network = local.vpc1.self_link
  region  = var.hub.vpc1.eu.region
  bgp {
    asn            = "16550"
    advertise_mode = "CUSTOM"

    advertised_ip_ranges {
      range = "10.0.0.0/8"
    }
  }
}

# interconnect attachment

resource "google_compute_interconnect_attachment" "megaport_zone1" {
  project                  = var.project_id
  name                     = "${var.hub.vpc1.prefix}megaport-zone1"
  type                     = "PARTNER"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  region                   = var.hub.vpc1.eu.region
  router                   = google_compute_router.megaport_router.self_link
  admin_enabled            = true
}

output "router" {
  value = google_compute_router.megaport_router
}

output "attachment" {
  value = google_compute_interconnect_attachment.megaport_zone1
}
