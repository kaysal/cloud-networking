# VPC Demo BGP Configuration
#----------------------------------------------
resource "google_compute_router_interface" "vpc_demo_router_interface" {
  count      = "${var.users}"
  name       = "vpc-demo-router-interface"
  router     = "vpc-demo-router"
  region     = "us-central1"
  ip_range   = "169.254.10.1/30"
  vpn_tunnel = "${element(google_compute_vpn_tunnel.tunnel_demo_to_onprem.*.name, count.index)}"
  project    = "${var.rand}-user${count.index+1}-${var.suffix}"

  depends_on = [
    "google_compute_vpn_tunnel.tunnel_demo_to_onprem",
  ]
}

## Create Peers
resource "google_compute_router_peer" "vpc_demo_bgp_peer" {
  count                     = "${var.users}"
  name                      = "vpc-demo-bgp-peer"
  router                    = "vpc-demo-router"
  region                    = "us-central1"
  peer_ip_address           = "169.254.10.2"
  peer_asn                  = "${var.vpc_onprem_asn}"
  advertised_route_priority = 500
  interface                 = "${element(google_compute_router_interface.vpc_demo_router_interface.*.name, count.index)}"
  project                   = "${var.rand}-user${count.index+1}-${var.suffix}"

  depends_on = [
    "google_compute_router_interface.vpc_demo_router_interface",
  ]
}


# VPC onprem BGP Configuration
#----------------------------------------------
resource "google_compute_router_interface" "vpc_onprem_router_interface" {
  count      = "${var.users}"
  name       = "vpc-onprem-router-interface"
  router     = "vpc-onprem-router"
  region     = "us-central1"
  ip_range   = "169.254.10.2/30"
  vpn_tunnel = "${element(google_compute_vpn_tunnel.tunnel_onprem_to_demo.*.name, count.index)}"
  project    = "${var.rand}-user${count.index+1}-${var.suffix}"

  depends_on = [
    "google_compute_vpn_tunnel.tunnel_onprem_to_demo",
  ]
}

## Create Peers
resource "google_compute_router_peer" "vpc_onprem_bgp_peer" {
  count                     = "${var.users}"
  name                      = "vpc-onprem-bgp-peer"
  router                    = "vpc-onprem-router"
  region                    = "us-central1"
  peer_ip_address           = "169.254.10.1"
  peer_asn                  = "${var.vpc_demo_asn}"
  advertised_route_priority = 500
  interface                 = "${element(google_compute_router_interface.vpc_onprem_router_interface.*.name, count.index)}"
  project                   = "${var.rand}-user${count.index+1}-${var.suffix}"

  depends_on = [
    "google_compute_router_interface.vpc_onprem_router_interface",
  ]
}
