
resource "google_compute_network_peering" "trust1_to_spoke1" {
  name                 = "${var.global.prefix}${var.hub.prefix}trust1-to-spoke1"
  network              = local.hub_vpc_trust1.self_link
  peer_network         = local.spoke1_vpc.self_link
  export_custom_routes = "true"
  import_custom_routes = "true"
}

resource "google_compute_network_peering" "spoke1_to_trust1" {
  name                 = "${var.global.prefix}${var.spoke1.prefix}to-hub-trust"
  network              = local.spoke1_vpc.self_link
  peer_network         = local.hub_vpc_trust1.self_link
  export_custom_routes = "true"
  import_custom_routes = "true"
}
