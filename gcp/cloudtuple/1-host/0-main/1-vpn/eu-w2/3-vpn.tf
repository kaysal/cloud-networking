locals {
  peer_ip   = "${data.terraform_remote_state.mango.vpn_gw_ip_eu_w2_addr}"
  local_vti = "169.254.200.1/30"
  peer_vti  = "169.254.200.2"
  peer_asn  = 65030
}

module "vpn-to-mango" {
  source                   = "../../../../../../modules/gcp/vpn"
  project_id               = "${data.terraform_remote_state.host.host_project_id}"
  network                  = "${data.google_compute_network.vpc.name}"
  region                   = "europe-west2"
  gateway_name             = "${var.main}vpn-gw-eu-w2"
  reserved_gateway_ip      = true
  gateway_ip               = "${data.terraform_remote_state.vpc.vpn_gw_ip_eu_w2_addr}"
  tunnel_name_prefix       = "${var.main}to-mango"
  shared_secret            = "${var.preshared_key}"
  tunnel_count             = 1
  cr_name                  = "${google_compute_router.cr_eu_w2.name}"
  peer_asn                 = ["${local.peer_asn"]
  remote_subnet            = [""]
  ike_version              = 2
  peer_ips                 = ["${local.peer_ip}"]
  bgp_cr_session_range     = ["${local.local_vti}"]
  bgp_remote_session_range = ["${local.peer_vti}"]
}
