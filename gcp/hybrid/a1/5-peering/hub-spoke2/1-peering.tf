
resource "google_compute_network_peering" "trust2_to_spoke2" {
  name                 = "${var.global.prefix}${var.hub.prefix}trust-to-spoke2"
  network              = local.hub_vpc_trust2.self_link
  peer_network         = local.spoke2_vpc.self_link
  export_custom_routes = "true"
  import_custom_routes = "true"
}

resource "google_compute_network_peering" "spoke2_to_trust2" {
  name                 = "${var.global.prefix}${var.spoke2.prefix}to-hub-trust"
  network              = local.spoke2_vpc.self_link
  peer_network         = local.hub_vpc_trust2.self_link
  export_custom_routes = "true"
  import_custom_routes = "true"
}
