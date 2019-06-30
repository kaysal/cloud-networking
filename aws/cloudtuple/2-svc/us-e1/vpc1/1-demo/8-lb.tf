# external alb

resource "aws_lb" "alb_ext" {
  name               = "${var.name}alb-ext"
  internal           = false
  load_balancer_type = "application"
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  security_groups = [data.terraform_remote_state.e1_vpc1.outputs.alb_pub_sg]

  subnets = [
    data.terraform_remote_state.e1_vpc1.outputs.public_172_18_0,
    data.terraform_remote_state.e1_vpc1.outputs.public_172_18_1,
  ]

  enable_deletion_protection = false

  /*
  access_logs {
    bucket  = "${aws_s3_bucket.lb_logs.bucket}"
    prefix  = "test-lb"
    enabled = true
  }
*/

  tags = {
    Name        = "${var.name}alb-ext"
    Environment = "production"
  }
}

# internal alb

resource "aws_lb" "alb_int" {
  name               = "${var.name}alb-int"
  internal           = true
  load_balancer_type = "application"
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  security_groups = [data.terraform_remote_state.e1_vpc1.outputs.alb_pub_sg]

  subnets = [
    data.terraform_remote_state.e1_vpc1.outputs.public_172_18_0,
    data.terraform_remote_state.e1_vpc1.outputs.public_172_18_1,
  ]

  enable_deletion_protection = false

  tags = {
    Name        = "${var.name}alb-int"
    Environment = "production"
  }
}

# nlb

resource "aws_lb" "nlb_int" {
  name                       = "${var.name}nlb-int"
  internal                   = true
  load_balancer_type         = "network"
  enable_deletion_protection = false

  subnets = [
    data.terraform_remote_state.e1_vpc1.outputs.private_172_18_10,
    data.terraform_remote_state.e1_vpc1.outputs.private_172_18_11,
  ]

  tags = {
    Environment = "production"
  }
}

