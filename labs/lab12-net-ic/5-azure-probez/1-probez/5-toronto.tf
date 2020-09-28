
data "template_file" "probe_toronto" {
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

module "toronto" {
  source            = "../../modules/azure-probe"
  prefix            = "${var.azure.prefix}toronto-"
  resource_group    = local.toronto_rg
  location          = var.azure.toronto.location
  subnet            = local.toronto_subnet
  public_ip         = local.toronto_ip
  ssh_public_key    = file(var.public_key_path)
  custom_script     = "${base64encode(data.template_file.probe_toronto.rendered)}"
  tags              = var.azure.tags
  module_depends_on = [module.singapore.vm_extension]
}
