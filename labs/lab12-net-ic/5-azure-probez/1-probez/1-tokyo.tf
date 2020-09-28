
data "template_file" "probe_tokyo" {
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

module "tokyo" {
  source            = "../../modules/azure-probe"
  prefix            = "${var.azure.prefix}tokyo-"
  resource_group    = local.tokyo_rg
  location          = var.azure.tokyo.location
  subnet            = local.tokyo_subnet
  public_ip         = local.tokyo_ip
  ssh_public_key    = file(var.public_key_path)
  custom_script     = "${base64encode(data.template_file.probe_tokyo.rendered)}"
  tags              = var.azure.tags
  module_depends_on = [""]
}
