data "aws_route53_zone" "cloudtuples" {
  name         = "cloudtuples.com."
  private_zone = false
}

resource "aws_route53_health_check" "alb_health_check" {
  fqdn              = "${aws_lb.alb.dns_name}"
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "5"
  request_interval  = "30"

  tags = {
    Name = "${var.name}alb-health-check"
  }
}

resource "aws_route53_record" "alb_cloudtuples" {
  zone_id = "${data.aws_route53_zone.cloudtuples.zone_id}"
  name    = "alb.${data.aws_route53_zone.cloudtuples.name}"
  type    = "A"

  alias {
    name                   = "${aws_lb.alb.dns_name}"
    zone_id                = "${aws_lb.alb.zone_id}"
    evaluate_target_health = true
  }

  set_identifier = "alb-Primary"

  failover_routing_policy {
    type = "PRIMARY"
  }

  health_check_id = "${aws_route53_health_check.alb_health_check.id}"

  depends_on = [
    "aws_lb.alb",
    "aws_route53_health_check.alb_health_check"
  ]
}
