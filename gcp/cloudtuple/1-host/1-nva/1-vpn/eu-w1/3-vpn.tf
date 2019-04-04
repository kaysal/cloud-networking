locals {
  peer1_tunnel_ip = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosa_tunnel_address}"
  peer2_tunnel_ip = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosb_tunnel_address}"
  vyosa_tunnel_gcp_vti = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosa_gcp_tunnel_inside_address2}"
  vyosb_tunnel_gcp_vti = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosb_gcp_tunnel_inside_address2}"
  vyosa_tunnel_aws_vti = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosa_aws_tunnel_inside_address2}"
  vyosb_tunnel_aws_vti = "${data.terraform_remote_state.aws_eu_w1_vpc1.vyosb_aws_tunnel_inside_address2}"
  peer_asn  = 65010
}

module "vpn-aws-eu-w1-vpc1" {
  source              = "github.com/kaysal/modules.git//gcp/vpn?ref=v1.0"
  project_id          = "${data.terraform_remote_state.host.host_project_id}"
  network             = "${data.google_compute_network.nva.name}"
  region              = "europe-west1"
  gateway_name        = "${var.nva}vpn-gw-eu-w1"
  reserved_gateway_ip = true
  gateway_ip          = "${data.terraform_remote_state.nva.vpn_gw_ip_eu_w1_addr}"
  tunnel_name_prefix  = "${var.nva}to-aws-eu-w1-vpc1-tunnel"
  shared_secret       = "${var.psk}"
  tunnel_count        = 2
  cr_name             = "${google_compute_router.cr_eu_w1.name}"
  peer_asn            = ["${local.peer_asn}", "${local.peer_asn}"]
  remote_subnet       = [""]
  ike_version         = 1

  peer_ips = [
    "${local.peer1_tunnel_ip}",
    "${local.peer2_tunnel_ip}",
  ]

  bgp_cr_session_range = [
    "${local.vyosa_tunnel_gcp_vti}/30",
    "${local.vyosb_tunnel_gcp_vti}/30",
  ]

  bgp_remote_session_range = [
    "${local.vyosa_tunnel_aws_vti}",
    "${local.vyosb_tunnel_aws_vti}",
  ]
}
