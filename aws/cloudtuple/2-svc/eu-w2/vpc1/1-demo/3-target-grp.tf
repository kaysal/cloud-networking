resource "aws_lb_target_group" "target_grp" {
  name                 = "${var.name}target-grp"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${data.terraform_remote_state.w2_vpc1.vpc1}"
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
    interval            = "30"
    matcher             = "200"
  }

  tags {
    Name = "${var.name}target-grp"
  }
}
