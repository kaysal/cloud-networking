
# vpn gw

module "vpngw1" {
  source     = "/home/salawu/tf_modules/gcp/vpn-gw"
  project_id = var.project_id_hub
  prefix     = "${var.global.prefix}${var.hub.prefix}"
  network    = local.hub_vpc_untrust.self_link
  region     = var.hub.untrust.eu1.region
  name       = "vpngw1"
}

module "vpngw2" {
  source     = "/home/salawu/tf_modules/gcp/vpn-gw"
  project_id = var.project_id_hub
  prefix     = "${var.global.prefix}${var.hub.prefix}"
  network    = local.hub_vpc_untrust.self_link
  region     = var.hub.untrust.eu2.region
  name       = "vpngw2"
}

# outputs

output "gateway" {
  value = {
    vpngw1 = module.vpngw1.gateway
    vpngw2 = module.vpngw2.gateway
  }
  sensitive = "true"
}
