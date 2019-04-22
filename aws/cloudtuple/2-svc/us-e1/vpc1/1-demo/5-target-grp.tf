# target group used for ASG
resource "aws_lb_target_group" "asg_tg" {
  name                 = "${var.name}asg-tg"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${data.terraform_remote_state.e1_vpc1.vpc1}"
  target_type          = "instance"
  deregistration_delay = "300"
  slow_start           = "0"

  stickiness {
    type            = "lb_cookie"
    cookie_duration = "86400"
    enabled         = false
  }

  health_check {
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = "/"
    healthy_threshold   = "5"
    unhealthy_threshold = "3"
    timeout             = "5"
    interval            = "10"
    matcher             = "200"
  }

  tags {
    Name = "${var.name}asg-tg"
  }
}

# target group with manually assigned ec2 instances
resource "aws_lb_target_group" "static_tg" {
  name                 = "${var.name}static-tg"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${data.terraform_remote_state.e1_vpc1.vpc1}"
  target_type          = "instance"
  deregistration_delay = "300"
  slow_start           = "0"

  stickiness {
    type            = "lb_cookie"
    cookie_duration = "86400"
    enabled         = false
  }

  health_check {
    protocol            = "HTTP"
    port                = "traffic-port"
    path                = "/"
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    timeout             = "5"
    interval            = "10"
    matcher             = "200"
  }

  tags {
    Name = "${var.name}static-tg"
  }
}

resource "aws_lb_target_group_attachment" "static_tg" {
  target_group_arn = "${aws_lb_target_group.static_tg.arn}"
  target_id        = "${aws_instance.web.id}"
  port             = 80
}
