provider "google" {}
provider "google-beta" {}

#============================================
# LAB 2 Base Config - NAT
#============================================

# VPC Module
#----------------------------------------
module "vpc_demo" {
  source       = "../../modules/1.vpc/vpc-demo"
  users        = "${local.users}"
  rand         = "${local.rand}"
  prefix       = "${local.prefix}"
  suffix       = "labs"
  asn          = "${local.vpc_demo_asn}"
  dependencies = []
}

# VPC On-premises
#----------------------------------------
module "vpc_onprem" {
  source       = "../../modules/1.vpc/vpc-onpr"
  users        = "${local.users}"
  rand         = "${local.rand}"
  prefix       = "${local.prefix}"
  suffix       = "labs"
  asn          = "${local.vpc_onprem_asn}"
  dependencies = []
}

# VPC SaaS Module
#----------------------------------------
module "vpc_saas" {
  source       = "../../modules/1.vpc/vpc-saas"
  users        = "${local.users}"
  rand         = "${local.rand}"
  prefix       = "${local.prefix}"
  suffix       = "labs"
  dependencies = []
}

# VPC Between VPC and VPC_Onprem
#----------------------------------------
module "vpc_demo_to_vpc_onprem_tunnel" {
  source           = "../../modules/vpn"
  users            = "${local.users}"
  rand             = "${local.rand}"
  prefix           = "${local.prefix}"
  suffix           = "labs"
  vpc_demo_asn     = "${local.vpc_demo_asn}"
  vpc_onprem_asn   = "${local.vpc_onprem_asn}"

  dependencies     = [
    "${module.vpc_demo.depended_on}",
    "${module.vpc_onprem.depended_on}",
  ]
}
