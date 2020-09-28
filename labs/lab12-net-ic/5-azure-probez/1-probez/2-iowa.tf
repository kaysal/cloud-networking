
data "template_file" "probe_iowa" {
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

module "iowa" {
  source            = "../../modules/azure-probe"
  prefix            = "${var.azure.prefix}iowa-"
  resource_group    = local.iowa_rg
  location          = var.azure.iowa.location
  subnet            = local.iowa_subnet
  public_ip         = local.iowa_ip
  ssh_public_key    = file(var.public_key_path)
  custom_script     = "${base64encode(data.template_file.probe_iowa.rendered)}"
  tags              = var.azure.tags
  module_depends_on = [module.tokyo.vm_extension]
}
