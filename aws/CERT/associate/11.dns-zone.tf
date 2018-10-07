data "aws_route53_zone" "cloudtuples" {
  name         = "cloudtuples.com."
  private_zone = false
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

  depends_on = ["aws_lb.alb"]
}

/*
resource "aws_route53_record" "alb_cloudtuples_s3" {
  zone_id = "${data.aws_route53_zone.cloudtuples.zone_id}"
  name    = "alb.${data.aws_route53_zone.cloudtuples.name}"
  type    = "A"

  alias {
    zone_id = "${data.aws_s3_bucket.selected.hosted_zone_id}"
    name    = "alb.${data.aws_route53_zone.cloudtuples.name}"
    evaluate_target_health = false
  }

  set_identifier = "alb-Secondary"
  failover_routing_policy {
    type = "SECONDARY"
  }

  depends_on = ["aws_lb.alb"]
}
*/

