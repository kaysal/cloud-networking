locals {
  peer_ip   = "${data.google_compute_address.eu_w2_vpn_gw_ip.address}"
  local_vti = "169.254.200.2/30"
  peer_vti  = "169.254.200.1"
  peer_asn  = 65000
}

module "vpn-to-host" {
  source                   = "terraform-google-modules/vpn/google"
  project_id               = "${data.terraform_remote_state.mango.mango_project_id}"
  network                  = "${data.google_compute_network.vpc.name}"
  region                   = "europe-west2"
  gateway_name             = "${var.main}eu-w2-vpn-gw"
  tunnel_name_prefix       = "${var.main}to-host"
  shared_secret            = "${var.psk}"
  tunnel_count             = 1
  cr_name                  = "${google_compute_router.eu_w2_cr.name}"
  peer_asn                 = ["${local.peer_asn}"]
  remote_subnet            = [""]
  ike_version              = 2
  peer_ips                 = ["${local.peer_ip}"]
  bgp_cr_session_range     = ["${local.local_vti}"]
  bgp_remote_session_range = ["${local.peer_vti}"]
}
