# org admin remote state files
data "terraform_remote_state" "pre" {
  backend = "gcs"

  config {
    bucket = "tf-shk"
    prefix = "${var.remote_state_path}"
  }
}

locals {
  users          = "${data.terraform_remote_state.pre.users}"
  rand           = "${data.terraform_remote_state.pre.rand}"
  prefix         = "${data.terraform_remote_state.pre.prefix}"
  offset         = "${data.terraform_remote_state.pre.offset}"
  vpc_demo_asn   = "${data.terraform_remote_state.pre.vpc_demo_asn}"
  vpc_onprem_asn = "${data.terraform_remote_state.pre.vpc_onprem_asn}"
}
