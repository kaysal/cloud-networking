
data "template_file" "probe_london" {
  template = file("scripts/probez.sh.tpl")
  vars = {
    GCLB_BROWSE   = "http://${local.gclb_vip}/browse/"
    GCLB_CART     = "http://${local.gclb_vip}/cart/"
    GCLB_CHECKOUT = "http://${local.gclb_vip}/checkout/"
    GCLB_STANDARD = "http://${local.gclb_standard_vip}/"
    TCP_PROXY     = "http://${local.mqtt_tcp_proxy_vip}:1883/"
    NUMBER        = 1
    COUNT         = 1
    HOST          = var.global.host
  }
}

module "london" {
  source            = "../../modules/azure-probe"
  prefix            = "${var.azure.prefix}london-"
  resource_group    = local.london_rg
  location          = var.azure.london.location
  subnet            = local.london_subnet
  public_ip         = local.london_ip
  ssh_public_key    = file(var.public_key_path)
  custom_script     = "${base64encode(data.template_file.probe_london.rendered)}"
  tags              = var.azure.tags
  module_depends_on = [module.iowa.vm_extension]
}
