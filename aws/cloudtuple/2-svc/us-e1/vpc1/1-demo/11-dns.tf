resource "aws_route53_record" "googleapis" {
  zone_id = "${data.aws_route53_zone.googleapis.zone_id}"
  name    = "*.googleapis.com"
  type    = "CNAME"
  ttl     = "300"
  records = ["restricted.googleapis.com"]
}

resource "aws_route53_record" "restricted_googleapis" {
  zone_id = "${data.aws_route53_zone.googleapis.zone_id}"
  name    = "restricted.googleapis.com"
  type    = "A"
  ttl     = "300"
  records = [
    "199.36.153.7",
    "199.36.153.6",
    "199.36.153.4",
    "199.36.153.5"
  ]
}
