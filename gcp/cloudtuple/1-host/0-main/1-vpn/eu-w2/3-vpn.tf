locals {
  peer_ip   = "${data.terraform_remote_state.mango.eu_w2_vpn_gw_ip}"
  local_vti = "169.254.200.1/30"
  peer_vti  = "169.254.200.2"
  peer_asn  = 65030
}

module "vpn-to-mango" {
  source                   = "terraform-google-modules/vpn/google"
  project_id               = "${data.terraform_remote_state.host.host_project_id}"
  network                  = "${data.google_compute_network.vpc.name}"
  region                   = "europe-west2"
  gateway_name             = "${var.main}eu-w2-vpn-gw"
  tunnel_name_prefix       = "${var.main}to-mango"
  shared_secret            = "${var.preshared_key}"
  tunnel_count             = 1
  cr_name                  = "${google_compute_router.eu_w2_cr_vpn_vpc.name}"
  peer_asn                 = ["${local.peer_asn}"]
  remote_subnet            = [""]
  ike_version              = 2
  peer_ips                 = ["${local.peer_ip}"]
  bgp_cr_session_range     = ["${local.local_vti}"]
  bgp_remote_session_range = ["${local.peer_vti}"]
}
