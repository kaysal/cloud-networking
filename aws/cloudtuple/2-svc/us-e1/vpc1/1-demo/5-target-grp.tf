# external alb target group used for ASG

resource "aws_lb_target_group" "alb_ext_asg_tg" {
  name                 = "${var.name}alb-ext-asg-tg"
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
    Name = "${var.name}alb-ext-asg-tg"
  }
}

# external alb target group with manually assigned ec2 instances

resource "aws_lb_target_group" "alb_ext_static_tg" {
  name                 = "${var.name}alb-ext-static-tg"
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
    Name = "${var.name}alb-ext-static-tg"
  }
}

resource "aws_lb_target_group_attachment" "alb_ext_static_tg" {
  target_group_arn = "${aws_lb_target_group.alb_ext_static_tg.arn}"
  target_id        = "${aws_instance.web_a.id}"
  port             = 80
}

# internal alb target group with manually assigned ec2 instances

resource "aws_lb_target_group" "alb_int_static_tg" {
  name                 = "${var.name}alb-int-static-tg"
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
    Name = "${var.name}alb-int-static-tg"
  }
}

resource "aws_lb_target_group_attachment" "alb_int_static_tg_a" {
  target_group_arn = "${aws_lb_target_group.alb_int_static_tg.arn}"
  target_id        = "${aws_instance.web_a.id}"
  port             = 80
}

resource "aws_lb_target_group_attachment" "alb_int_static_tg_b" {
  target_group_arn = "${aws_lb_target_group.alb_int_static_tg.arn}"
  target_id        = "${aws_instance.web_b.id}"
  port             = 80
}

# nlb target group with manually assigned ec2 instances

resource "aws_lb_target_group" "nlb_static_tg" {
  name                 = "${var.name}nlb-static-tg"
  port                 = 80
  protocol             = "TCP"
  vpc_id               = "${data.terraform_remote_state.e1_vpc1.vpc1}"
  target_type          = "instance"

  health_check {
    protocol            = "TCP"
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }

  tags {
    Name = "${var.name}nlb-static-tg"
  }
}

# us-east-1a

resource "aws_lb_target_group_attachment" "nlb_int_static_tg_a" {
  target_group_arn = "${aws_lb_target_group.nlb_static_tg.arn}"
  target_id        = "${aws_instance.web_a.id}"
  port             = 80
}

# us-east-1b

resource "aws_lb_target_group_attachment" "nlb_int_static_tg_b" {
  target_group_arn = "${aws_lb_target_group.nlb_static_tg.arn}"
  target_id        = "${aws_instance.web_b.id}"
  port             = 80
}
