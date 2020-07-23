
# router

resource "google_compute_router" "cr1" {
  project = var.project_id_hub
  name    = "${var.global.prefix}${var.hub.prefix}cr1"
  network = local.hub_vpc_untrust.self_link
  region  = var.hub.region.eu1

  bgp {
    asn               = var.hub.untrust.asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]

    # restricted.googleapis.com
    advertised_ip_ranges {
      range = "199.36.153.4/30"
    }

    advertised_ip_ranges {
      range = var.hub.trust1.cidr.spoke1
    }
  }
}

resource "google_compute_router" "cr2" {
  project = var.project_id_hub
  name    = "${var.global.prefix}${var.hub.prefix}cr2"
  network = local.hub_vpc_untrust.self_link
  region  = var.hub.region.eu2

  bgp {
    asn               = var.hub.untrust.asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]

    # restricted.googleapis.com
    advertised_ip_ranges {
      range = "199.36.153.4/30"
    }

    advertised_ip_ranges {
      range = var.hub.trust2.cidr.spoke2
    }
  }
}

# vpn tunnel

module "vpngw1_tun1" {
  source                    = "/home/salawu/tf_modules/gcp/vpn"
  project_id                = var.project_id_hub
  network                   = local.hub_vpc_untrust.self_link
  region                    = var.hub.region.eu1
  gateway                   = module.vpngw1.gateway.self_link
  tunnel_name               = "${var.global.prefix}${var.hub.prefix}vpngw1-tun1"
  shared_secret             = var.global.psk
  peer_ip                   = aws_vpn_connection.vpngw1.tunnel1_address
  cr_name                   = google_compute_router.cr1.name
  bgp_cr_session_range      = "${aws_vpn_connection.vpngw1.tunnel1_cgw_inside_address}/30"
  bgp_remote_session_range  = aws_vpn_connection.vpngw1.tunnel1_vgw_inside_address
  peer_asn                  = var.onprem.asn
  advertised_route_priority = 100
}

module "vpngw1_tun2" {
  source                    = "/home/salawu/tf_modules/gcp/vpn"
  project_id                = var.project_id_hub
  network                   = local.hub_vpc_untrust.self_link
  region                    = var.hub.region.eu1
  gateway                   = module.vpngw1.gateway.self_link
  tunnel_name               = "${var.global.prefix}${var.hub.prefix}vpngw1-tun2"
  shared_secret             = var.global.psk
  peer_ip                   = aws_vpn_connection.vpngw1.tunnel2_address
  cr_name                   = google_compute_router.cr1.name
  bgp_cr_session_range      = "${aws_vpn_connection.vpngw1.tunnel2_cgw_inside_address}/30"
  bgp_remote_session_range  = aws_vpn_connection.vpngw1.tunnel2_vgw_inside_address
  peer_asn                  = var.onprem.asn
  advertised_route_priority = 100
}

module "vpngw2_tun1" {
  source                    = "/home/salawu/tf_modules/gcp/vpn"
  project_id                = var.project_id_hub
  network                   = local.hub_vpc_untrust.self_link
  region                    = var.hub.region.eu2
  gateway                   = module.vpngw2.gateway.self_link
  tunnel_name               = "${var.global.prefix}${var.hub.prefix}vpngw2-tun1"
  shared_secret             = var.global.psk
  peer_ip                   = aws_vpn_connection.vpngw2.tunnel1_address
  cr_name                   = google_compute_router.cr2.name
  bgp_cr_session_range      = "${aws_vpn_connection.vpngw2.tunnel1_cgw_inside_address}/30"
  bgp_remote_session_range  = aws_vpn_connection.vpngw2.tunnel1_vgw_inside_address
  peer_asn                  = var.onprem.asn
  advertised_route_priority = 100
}

module "vpngw2_tun2" {
  source                    = "/home/salawu/tf_modules/gcp/vpn"
  project_id                = var.project_id_hub
  network                   = local.hub_vpc_untrust.self_link
  region                    = var.hub.region.eu2
  gateway                   = module.vpngw2.gateway.self_link
  tunnel_name               = "${var.global.prefix}${var.hub.prefix}vpngw2-tun2"
  shared_secret             = var.global.psk
  peer_ip                   = aws_vpn_connection.vpngw2.tunnel2_address
  cr_name                   = google_compute_router.cr2.name
  bgp_cr_session_range      = "${aws_vpn_connection.vpngw2.tunnel2_cgw_inside_address}/30"
  bgp_remote_session_range  = aws_vpn_connection.vpngw2.tunnel2_vgw_inside_address
  peer_asn                  = var.onprem.asn
  advertised_route_priority = 100
}
