# service producer side

resource "aws_vpc_endpoint_service" "endpoint_svc" {
  acceptance_required        = false
  network_load_balancer_arns = ["${aws_lb.nlb_int.arn}"]
}

# service consumer side

resource "aws_vpc_endpoint" "nlb_endpoint_svc" {
  vpc_id              = "${data.terraform_remote_state.e1_vpc1.vpc1}"
  service_name        = "${aws_vpc_endpoint_service.endpoint_svc.service_name}"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = ["${data.terraform_remote_state.e1_vpc1.endpoint_sg}"]
  private_dns_enabled = false
}

resource "aws_vpc_endpoint_subnet_association" "nlb_svc_private_172_18_10" {
  vpc_endpoint_id = "${aws_vpc_endpoint.nlb_endpoint_svc.id}"
  subnet_id       = "${data.terraform_remote_state.e1_vpc1.private_172_18_10}"
}

resource "aws_vpc_endpoint_subnet_association" "nlb_svc_private_172_18_11" {
  vpc_endpoint_id = "${aws_vpc_endpoint.nlb_endpoint_svc.id}"
  subnet_id       = "${data.terraform_remote_state.e1_vpc1.private_172_18_11}"
}
