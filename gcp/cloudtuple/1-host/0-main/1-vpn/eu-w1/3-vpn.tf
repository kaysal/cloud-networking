locals {
  peer1_tunnel_ip = "${data.terraform_remote_state.aws.vyosa_tunnel_address}"
  peer2_tunnel_ip = "${data.terraform_remote_state.aws.vyosb_tunnel_address}"
}

locals {
  vyosa_tunnel_gcp_vti = "${data.terraform_remote_state.aws.vyosa_gcp_tunnel_inside_address}"
  vyosb_tunnel_gcp_vti = "${data.terraform_remote_state.aws.vyosb_gcp_tunnel_inside_address}"
  vyosa_tunnel_aws_vti = "${data.terraform_remote_state.aws.vyosa_aws_tunnel_inside_address}"
  vyosb_tunnel_aws_vti = "${data.terraform_remote_state.aws.vyosb_aws_tunnel_inside_address}"
}

module "vpn-aws-eu-w1-vpc1" {
  source             = "github.com/kaysal/cloud-networking/modules/gcp/network/hybrid/vpn"
  project_id         = "${data.terraform_remote_state.host.host_project_id}"
  network            = "${data.google_compute_network.vpc.name}"
  region             = "europe-west1"
  gateway_name       = "${var.main}eu-w1-vpn-gw1"
  tunnel_name_prefix = "test"
  shared_secret      = "${var.preshared_key}"
  tunnel_count       = 2
  cr_name            = "${google_compute_router.eu_w1_cr_vpn.name}"
  peer_asn = ["65010", "65010"]

  peer_ips = [
    "${local.peer1_tunnel_ip}",
    "${local.peer2_tunnel_ip}",
  ]

  bgp_cr_session_range = [
    "${local.vyosa_tunnel_gcp_vti}/30",
    "${local.vyosb_tunnel_gcp_vti}/30"
  ]

  bgp_remote_session_range = [
    "${local.vyosa_tunnel_aws_vti}",
    "${local.vyosb_tunnel_aws_vti}"
  ]
}
