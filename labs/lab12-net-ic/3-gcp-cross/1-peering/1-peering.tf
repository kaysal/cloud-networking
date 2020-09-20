
# vpc1 <--> spoke
/*
resource "google_compute_network_peering" "vpc1_to_spoke" {
  provider     = google-beta
  name         = "vpc1-to-spoke"
  network      = local.vpc1.self_link
  peer_network = local.spoke.self_link

  export_custom_routes = true
  import_custom_routes = true

  #export_subnet_routes_with_public_ip = true
  #import_subnet_routes_with_public_ip = true
}

# spoke to hub

resource "google_compute_network_peering" "spoke_to_hub" {
  provider     = google-beta
  name         = "spoke-to-hub"
  network      = local.spoke.self_link
  peer_network = local.vpc1.self_link

  export_custom_routes = true
  import_custom_routes = true

  #export_subnet_routes_with_public_ip = true
  #import_subnet_routes_with_public_ip = true
}*/


# vpc2 <--> spoke

resource "google_compute_network_peering" "vpc2_to_spoke" {
  provider     = google-beta
  name         = "vpc2-to-spoke"
  network      = local.vpc2.self_link
  peer_network = local.spoke.self_link

  export_custom_routes = true
  import_custom_routes = true

  #export_subnet_routes_with_public_ip = true
  #import_subnet_routes_with_public_ip = true
}

# spoke to hub

resource "google_compute_network_peering" "spoke_to_hub" {
  provider     = google-beta
  name         = "spoke-to-hub"
  network      = local.spoke.self_link
  peer_network = local.vpc2.self_link

  export_custom_routes = true
  import_custom_routes = true

  #export_subnet_routes_with_public_ip = true
  #import_subnet_routes_with_public_ip = true
}
