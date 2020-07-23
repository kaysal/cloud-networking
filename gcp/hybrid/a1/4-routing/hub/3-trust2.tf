/*
# default internet

resource "google_compute_route" "route_b1" {
  name                   = "${var.global.prefix}${var.hub.prefix}route-b1"
  dest_range             = "0.0.0.0/1"
  network                = local.vpc_trust2.self_link
  next_hop_instance_zone = "${var.hub.region.eu2}-b"
  next_hop_instance      = local.vm_eu2_nva1.name
  priority               = "100"
}

resource "google_compute_route" "route_b2" {
  name                   = "${var.global.prefix}${var.hub.prefix}route-b2"
  dest_range             = "128.0.0.0/1"
  network                = local.vpc_trust2.self_link
  next_hop_instance_zone = "${var.hub.region.eu2}-b"
  next_hop_instance      = local.vm_eu2_nva1.name
  priority               = "100"
}

resource "google_compute_route" "route_c1" {
  name                   = "${var.global.prefix}${var.hub.prefix}route-c1"
  dest_range             = "0.0.0.0/1"
  network                = local.vpc_trust2.self_link
  next_hop_instance_zone = "${var.hub.region.eu2}-c"
  next_hop_instance      = local.vm_eu2_nva2.name
  priority               = "100"
}

resource "google_compute_route" "route_c2" {
  name                   = "${var.global.prefix}${var.hub.prefix}route-c2"
  dest_range             = "128.0.0.0/1"
  network                = local.vpc_trust2.self_link
  next_hop_instance_zone = "${var.hub.region.eu2}-c"
  next_hop_instance      = local.vm_eu2_nva2.name
  priority               = "100"
}*/

# onprem

resource "google_compute_route" "trust2_onprem_b" {
  name                   = "${var.global.prefix}${var.hub.prefix}trust2-onprem-b"
  dest_range             = var.onprem.vpc
  network                = local.vpc_trust2.self_link
  next_hop_instance_zone = "${var.hub.region.eu2}-b"
  next_hop_instance      = local.vm_eu2_nva1.name
  priority               = "100"
}

resource "google_compute_route" "trust2_onprem_c" {
  name                   = "${var.global.prefix}${var.hub.prefix}trust2-onprem-c"
  dest_range             = var.onprem.vpc
  network                = local.vpc_trust2.self_link
  next_hop_instance_zone = "${var.hub.region.eu2}-c"
  next_hop_instance      = local.vm_eu2_nva2.name
  priority               = "100"
}
