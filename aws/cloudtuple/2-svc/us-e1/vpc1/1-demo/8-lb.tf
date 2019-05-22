# external alb

resource "aws_lb" "alb_ext" {
  name               = "${var.name}alb-ext"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${data.terraform_remote_state.e1_vpc1.alb_pub_sg}"]

  subnets = [
    "${data.terraform_remote_state.e1_vpc1.public_172_18_0}",
    "${data.terraform_remote_state.e1_vpc1.public_172_18_1}",
  ]

  enable_deletion_protection = false

  /*
  access_logs {
    bucket  = "${aws_s3_bucket.lb_logs.bucket}"
    prefix  = "test-lb"
    enabled = true
  }
*/

  tags {
    Name        = "${var.name}alb-ext"
    Environment = "production"
  }
}

# internal alb

resource "aws_lb" "alb_int" {
  name               = "${var.name}alb-int"
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${data.terraform_remote_state.e1_vpc1.alb_pub_sg}"]

  subnets = [
    "${data.terraform_remote_state.e1_vpc1.public_172_18_0}",
    "${data.terraform_remote_state.e1_vpc1.public_172_18_1}",
  ]

  enable_deletion_protection = false

  tags {
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
    "${data.terraform_remote_state.e1_vpc1.private_172_18_10}",
    "${data.terraform_remote_state.e1_vpc1.private_172_18_11}",
  ]

  tags = {
    Environment = "production"
  }
}
