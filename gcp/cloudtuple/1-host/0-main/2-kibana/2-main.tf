provider "opc" {
  user = "${var.user}"
  password	= "${var.password}"
  identity_domain = "${var.identity_domain}"
  endpoint 	= "${var.endpoint}"
}

module "elk_stack" {
  source = "github.com/kaysal/ocic-modules.git//services/forward-proxy?ref=v1.0.0"
  remote_state_network_data = "../../states/network/terraform.tfstate"
  instance_name = "ks_FProxy"
  ip_address = "172.16.2.2"
  instance_shape = "oc3"
  boot_volume_image_list = "/oracle/public/OL_7.2_UEKR4_x86_64"
  search_domains   = ["cloud.oracle.com", "oraclecloud.com"]
}
