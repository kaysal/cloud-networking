locals {
  cgw1_tunnel1_ip      = data.terraform_remote_state.aws_us_e1_vpc1.outputs.aws_cgw1_tunnel1_address
  cgw1_tunnel2_ip      = data.terraform_remote_state.aws_us_e1_vpc1.outputs.aws_cgw1_tunnel2_address
  cgw2_tunnel1_ip      = data.terraform_remote_state.aws_us_e1_vpc1.outputs.aws_cgw2_tunnel1_address
  cgw2_tunnel2_ip      = data.terraform_remote_state.aws_us_e1_vpc1.outputs.aws_cgw2_tunnel2_address
  cgw1_tunnel1_aws_vti = data.terraform_remote_state.aws_us_e1_vpc1.outputs.aws_cgw1_tunnel1_vgw_inside_address
  cgw1_tunnel2_aws_vti = data.terraform_remote_state.aws_us_e1_vpc1.outputs.aws_cgw1_tunnel2_vgw_inside_address
  cgw1_tunnel1_gcp_vti = data.terraform_remote_state.aws_us_e1_vpc1.outputs.gcp_cgw1_tunnel1_cgw_inside_address
  cgw1_tunnel2_gcp_vti = data.terraform_remote_state.aws_us_e1_vpc1.outputs.gcp_cgw1_tunnel2_cgw_inside_address
  cgw2_tunnel1_aws_vti = data.terraform_remote_state.aws_us_e1_vpc1.outputs.aws_cgw2_tunnel1_vgw_inside_address
  cgw2_tunnel2_aws_vti = data.terraform_remote_state.aws_us_e1_vpc1.outputs.aws_cgw2_tunnel2_vgw_inside_address
  cgw2_tunnel1_gcp_vti = data.terraform_remote_state.aws_us_e1_vpc1.outputs.gcp_cgw2_tunnel1_cgw_inside_address
  cgw2_tunnel2_gcp_vti = data.terraform_remote_state.aws_us_e1_vpc1.outputs.gcp_cgw2_tunnel2_cgw_inside_address
  peer_asn             = 65010
}

# vpn gateway 1

module "vpn_aws_us_e1_vpc1_cgw1" {
  source        = "github.com/kaysal/modules.git//gcp/vpn"
  project_id    = data.terraform_remote_state.host.outputs.host_project_id
  network       = data.google_compute_network.vpc.name
  region        = "us-east1"
  gateway_name  = "${var.main}us-e1-vpn-gw1"
  gateway_ip    = data.google_compute_address.vpn_gw1_ip_us_e1.address
  shared_secret = var.psk
  cr_name       = google_compute_router.us_e1_cr_vpn_vpc.name
  ike_version   = 1

  tunnels = [
    {
      tunnel_name               = "aws-us-e1-vpc1-cgw1-tun-1"
      peer_ip                   = local.cgw1_tunnel1_ip
      peer_asn                  = local.peer_asn
      cr_bgp_session_range      = "${local.cgw1_tunnel1_gcp_vti}/30"
      remote_bgp_session_ip     = local.cgw1_tunnel1_aws_vti
      advertised_route_priority = 100
    },
    {
      tunnel_name               = "aws-us-e1-vpc1-cgw1-tun-2"
      peer_ip                   = local.cgw1_tunnel2_ip
      peer_asn                  = local.peer_asn
      cr_bgp_session_range      = "${local.cgw1_tunnel2_gcp_vti}/30"
      remote_bgp_session_ip     = local.cgw1_tunnel2_aws_vti
      advertised_route_priority = 100
    },
  ]
}

# vpn gateway 2

module "vpn_aws_us_e1_vpc1_cgw2" {
  source        = "github.com/kaysal/modules.git//gcp/vpn"
  project_id    = data.terraform_remote_state.host.outputs.host_project_id
  network       = data.google_compute_network.vpc.name
  region        = "us-east1"
  gateway_name  = "${var.main}us-e1-vpn-gw2"
  gateway_ip    = data.google_compute_address.vpn_gw2_ip_us_e1.address
  shared_secret = var.psk
  cr_name       = google_compute_router.us_e1_cr_vpn_vpc.name
  ike_version   = 1

  tunnels = [
    {
      tunnel_name               = "aws-us-e1-vpc1-cgw2-tun-1"
      peer_ip                   = local.cgw2_tunnel1_ip
      peer_asn                  = local.peer_asn
      cr_bgp_session_range      = "${local.cgw2_tunnel1_gcp_vti}/30"
      remote_bgp_session_ip     = local.cgw2_tunnel1_aws_vti
      advertised_route_priority = 100
    },
    {
      tunnel_name               = "aws-us-e1-vpc1-cgw2-tun-2"
      peer_ip                   = local.cgw2_tunnel2_ip
      peer_asn                  = local.peer_asn
      cr_bgp_session_range      = "${local.cgw2_tunnel2_gcp_vti}/30"
      remote_bgp_session_ip     = local.cgw2_tunnel2_aws_vti
      advertised_route_priority = 100
    },
  ]
}
