#============================================
# LAB 2 Base Config - NAT
#============================================
# Create Lab 2 Project under each user's folder
#----------------------------------------
resource "google_project" "lab2" {
  count           = "${local.count}"
  name            = "${local.rand}-user${count.index + local.offset}-lab2"
  folder_id       = "${element(google_folder.folder.*.name, count.index)}"
  project_id      = "${local.rand}-user${count.index + local.offset}-lab2"
  billing_account = "${var.billing_account_id}"
}

resource "google_project_services" "lab2" {
  count   = "${local.count}"
  project = "${local.rand}-user${count.index + local.offset}-lab2"

  services = [
    "compute.googleapis.com",
    "oslogin.googleapis.com",
  ]

  depends_on = ["google_project.lab2"]
}

# VPC Module
#----------------------------------------
module "vpc" {
  source = "../../modules/1.vpc/vpc"
  count  = "${local.count}"
  rand   = "${local.rand}"
  prefix = "${local.prefix}"
  suffix = "lab2"
  asn    = "${local.vpc_asn}"

  dependencies = [
    "google_project.lab2",
    "google_project_services.lab2",
  ]
}

# VPC On-premises
#----------------------------------------
module "vpc_onprem" {
  source = "../../modules/1.vpc/vpc-onpr"
  count  = "${local.count}"
  rand   = "${local.rand}"
  prefix = "${local.prefix}"
  suffix = "lab2"
  asn    = "${local.vpc_onprem_asn}"

  dependencies = [
    "google_project.lab2",
    "google_project_services.lab2",
  ]
}

# VPC SaaS Module
#----------------------------------------
module "vpc_saas" {
  source = "../../modules/1.vpc/vpc-saas"
  count  = "${local.count}"
  rand   = "${local.rand}"
  prefix = "${local.prefix}"
  suffix = "lab2"

  dependencies = [
    "google_project.lab2",
    "google_project_services.lab2",
  ]
}
/*
# VPC Between VPC and VPC_Onprem
#----------------------------------------

# VPN Tunnel configuration in VPC
module "vpc_tunnel" {
  source              = "github.com/kaysal/modules.git//gcp/vpn?ref=v1.0"
  project_id          = "${data.terraform_remote_state.host.host_project_id}"
  network             = "${data.google_compute_network.nva.name}"
  region              = "europe-west1"
  gateway_name        = "${var.nva}vpc-demo-gw"
  #reserved_gateway_ip = false
  #gateway_ip          = "${data.terraform_remote_state.nva.vpn_gw_ip_eu_w1_addr}"
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
*/
