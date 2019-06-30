locals {
  peer_ip   = data.terraform_remote_state.mango.outputs.vpn_gw_ip_eu_w2_addr
  local_vti = "169.254.200.1"
  peer_vti  = "169.254.200.2"
  peer_asn  = 65030
}

module "vpn_to_mango" {
  source        = "github.com/kaysal/modules.git//gcp/vpn"
  project_id    = data.terraform_remote_state.host.outputs.host_project_id
  network       = data.google_compute_network.vpc.name
  region        = "europe-west2"
  gateway_name  = "${var.main}vpn-gw-eu-w2"
  gateway_ip    = data.terraform_remote_state.vpc.outputs.vpn_gw_ip_eu_w2_addr
  shared_secret = var.psk
  cr_name       = google_compute_router.cr_eu_w2.name
  ike_version   = 1

  tunnels = [
    {
      tunnel_name               = "${var.main}mango"
      peer_ip                   = local.peer_ip
      peer_asn                  = local.peer_asn
      cr_bgp_session_range      = "${local.local_vti}/30"
      remote_bgp_session_ip     = local.peer_vti
      advertised_route_priority = 100
    },
  ]
}
