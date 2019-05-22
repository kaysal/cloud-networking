resource "aws_route53_health_check" "alb_health_check" {
  fqdn              = "${aws_lb.alb_ext.dns_name}"
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = "2"
  request_interval  = "10"

  tags = {
    Name = "${var.name}alb-health-check"
  }
}

# Zone record set for ALB = PRIMARY
#==============================
resource "aws_route53_record" "alb_cloudtuples" {
  zone_id = "${data.aws_route53_zone.cloudtuples_public.zone_id}"
  name    = "alb.${data.aws_route53_zone.cloudtuples_public.name}"
  type    = "A"

  alias {
    name                   = "${aws_lb.alb_ext.dns_name}"
    zone_id                = "${aws_lb.alb_ext.zone_id}"
    evaluate_target_health = true
  }

  set_identifier = "alb-Primary"

  failover_routing_policy {
    type = "PRIMARY"
  }

  health_check_id = "${aws_route53_health_check.alb_health_check.id}"

  depends_on = [
    "aws_lb.alb_ext",
    "aws_route53_health_check.alb_health_check",
  ]
}

# Zone record for S3 bucket = SECONDARY
#==============================
resource "aws_route53_record" "alb_cloudtuples_s3" {
  zone_id = "${data.aws_route53_zone.cloudtuples_public.zone_id}"
  name    = "alb.${data.aws_route53_zone.cloudtuples_public.name}"
  type    = "A"

  alias {
    zone_id                = "${aws_s3_bucket.site.hosted_zone_id}"
    name                   = "${aws_s3_bucket.site.website_domain}"
    evaluate_target_health = false
  }

  set_identifier = "alb-Secondary"

  failover_routing_policy {
    type = "SECONDARY"
  }
}
