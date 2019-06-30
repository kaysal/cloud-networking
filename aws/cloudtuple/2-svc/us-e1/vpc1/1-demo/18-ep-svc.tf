# service producer side

resource "aws_vpc_endpoint_service" "endpoint_svc" {
  acceptance_required        = false
  network_load_balancer_arns = [aws_lb.nlb_int.arn]
}

# service consumer side

resource "aws_vpc_endpoint" "nlb_endpoint_svc" {
  vpc_id            = data.terraform_remote_state.e1_vpc1.outputs.vpc1
  service_name      = aws_vpc_endpoint_service.endpoint_svc.service_name
  vpc_endpoint_type = "Interface"
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  security_group_ids  = [data.terraform_remote_state.e1_vpc1.outputs.endpoint_sg]
  private_dns_enabled = false
}

resource "aws_vpc_endpoint_subnet_association" "nlb_svc_private_172_18_10" {
  vpc_endpoint_id = aws_vpc_endpoint.nlb_endpoint_svc.id
  subnet_id       = data.terraform_remote_state.e1_vpc1.outputs.private_172_18_10
}

resource "aws_vpc_endpoint_subnet_association" "nlb_svc_private_172_18_11" {
  vpc_endpoint_id = aws_vpc_endpoint.nlb_endpoint_svc.id
  subnet_id       = data.terraform_remote_state.e1_vpc1.outputs.private_172_18_11
}

