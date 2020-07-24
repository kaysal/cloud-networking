
# cloud router

resource "google_compute_router" "vpc_alamos_cr" {
  name    = "vpc-alamos-cr"
  network = "default"
  region  = "europe-west2"

  bgp {
    asn               = "64598"
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]

    # elastifile range
    advertised_ip_ranges {
      range = "10.16.0.1/32"
    }
  }
}

resource "google_compute_router" "vpc_alamos_cr_nic" {
  project = "nic-host-project"
  name    = "vpc-alamos-cr-nic"
  network = local.vpc_nic.self_link
  region  = "europe-west2"

  bgp {
    asn            = "64599"
    advertise_mode = "CUSTOM"

    # dell server 1
    advertised_ip_ranges {
      range = "192.168.11.0/24"
    }

    # dell server 2
    advertised_ip_ranges {
      range = "192.168.22.0/24"
    }
  }
}

# vpn gateways

resource "google_compute_ha_vpn_gateway" "vpc_alamos_vpngw" {
  provider = google-beta
  region   = "europe-west2"
  name     = "vpc-alamos-vpngw"
  network  = "default"
}

resource "google_compute_ha_vpn_gateway" "vpc_alamos_vpngw_nic" {
  provider = google-beta
  project  = "nic-host-project"
  region   = "europe-west2"
  name     = "vpc-alamos-vpngw"
  network  = local.vpc_nic.self_link
}

# vpn tunnels

module "vpn_alamos_to_nic" {
  source           = "/home/salawu/tf_modules/gcp/vpn-gcp"
  project_id       = var.project_id
  network          = "default"
  region           = "europe-west2"
  vpn_gateway      = google_compute_ha_vpn_gateway.vpc_alamos_vpngw.self_link
  peer_gcp_gateway = google_compute_ha_vpn_gateway.vpc_alamos_vpngw_nic.self_link
  shared_secret    = "password123"
  router           = google_compute_router.vpc_alamos_cr.name
  ike_version      = 2

  session_config = [
    {
      session_name              = "alamos-to-nic"
      peer_asn                  = "64599"
      cr_bgp_session_range      = "169.254.150.1/30"
      remote_bgp_session_ip     = "169.254.150.2"
      advertised_route_priority = "100"
    },
    {
      session_name              = "alamos-to-nic"
      peer_asn                  = "64599"
      cr_bgp_session_range      = "169.254.150.5/30"
      remote_bgp_session_ip     = "169.254.150.6"
      advertised_route_priority = "100"
    },
  ]
}

module "vpn_nic_to_alamos" {
  source           = "/home/salawu/tf_modules/gcp/vpn-gcp"
  project_id       = "nic-host-project"
  network          = local.vpc_nic.self_link
  region           = "europe-west2"
  vpn_gateway      = google_compute_ha_vpn_gateway.vpc_alamos_vpngw_nic.self_link
  peer_gcp_gateway = google_compute_ha_vpn_gateway.vpc_alamos_vpngw.self_link
  shared_secret    = "password123"
  router           = google_compute_router.vpc_alamos_cr_nic.name
  ike_version      = 2

  session_config = [
    {
      session_name              = "nic-to-alamos"
      peer_asn                  = "64598"
      cr_bgp_session_range      = "169.254.150.2/30"
      remote_bgp_session_ip     = "169.254.150.1"
      advertised_route_priority = "100"
    },
    {
      session_name              = "nic-to-alamos"
      peer_asn                  = "64598"
      cr_bgp_session_range      = "169.254.150.6/30"
      remote_bgp_session_ip     = "169.254.150.5"
      advertised_route_priority = "100"
    },
  ]
}
