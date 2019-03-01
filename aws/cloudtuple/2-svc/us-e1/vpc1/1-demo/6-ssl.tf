data "aws_acm_certificate" "cdn_use1_cloudtuples" {
  #provider = "aws.us-e1"
  domain   = "${var.domain_name}"
  statuses = ["ISSUED"]
}

data "aws_acm_certificate" "alb_euw2_cloudtuples" {
  domain   = "${var.domain_name}"
  statuses = ["ISSUED"]
}
