resource "aws_lb_listener" "listener_80" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.asg_tg.arn}"
  }
}

resource "aws_lb_listener" "listener_443" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = "${data.aws_acm_certificate.alb_euw2_cloudtuples.arn}"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.asg_tg.arn}"
  }
}

resource "aws_lb_listener_rule" "server_host_path" {
  listener_arn = "${aws_lb_listener.listener_443.arn}"
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.static_tg.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/server.php"]
  }
}

/*
# additional certificates if required
resource "aws_lb_listener_certificate" "alb_cloudtuples" {
  listener_arn    = "${aws_lb_listener.https_listener.arn}"
  certificate_arn = "${data.aws_acm_certificate.cloudtuples.arn}"
}
*/
