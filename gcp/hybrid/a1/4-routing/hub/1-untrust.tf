
# spoke1

resource "google_compute_route" "untrust_spoke1_b" {
  name                   = "${var.global.prefix}${var.hub.prefix}untrust-spoke1-b"
  dest_range             = var.spoke1.cidr
  network                = local.vpc_untrust.self_link
  next_hop_instance_zone = "${var.hub.region.eu1}-b"
  next_hop_instance      = local.vm_eu1_nva1.name
  priority               = "100"
}

resource "google_compute_route" "untrust_spoke1_c" {
  name                   = "${var.global.prefix}${var.hub.prefix}untrust-spoke1-c"
  dest_range             = var.spoke1.cidr
  network                = local.vpc_untrust.self_link
  next_hop_instance_zone = "${var.hub.region.eu1}-c"
  next_hop_instance      = local.vm_eu1_nva2.name
  priority               = "100"
}

# spoke1

resource "google_compute_route" "untrust_spoke2_b" {
  name                   = "${var.global.prefix}${var.hub.prefix}untrust-spoke2-b"
  dest_range             = var.spoke2.cidr
  network                = local.vpc_untrust.self_link
  next_hop_instance_zone = "${var.hub.region.eu2}-b"
  next_hop_instance      = local.vm_eu2_nva1.name
  priority               = "100"
}

resource "google_compute_route" "untrust_spoke2_c" {
  name                   = "${var.global.prefix}${var.hub.prefix}untrust-spoke2-c"
  dest_range             = var.spoke2.cidr
  network                = local.vpc_untrust.self_link
  next_hop_instance_zone = "${var.hub.region.eu2}-c"
  next_hop_instance      = local.vm_eu2_nva2.name
  priority               = "100"
}
