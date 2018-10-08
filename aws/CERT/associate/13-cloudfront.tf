resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  s3_origin_id = "myS3Origin"
}


resource "aws_cloudfront_distribution" "site_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.site.bucket_domain_name}"
    origin_id   = "${local.s3_origin_id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"
  custom_error_response = {
    error_code = "404"
    response_code = "404"
    response_page_path = "/error.html"
  }

  aliases             = ["cdn${random_id.suffix.hex}.cloudtuples.com"]

  default_cache_behavior {
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT",]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "allow-all"
  }

  price_class         = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US","CA","GB","DE","FR","NL","NG","ES","TT","CH" ]
    }
  }

  tags {
    Environment = "production"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# s3 buscket (secondary) to alb (primary)
resource "aws_route53_record" "alb_cloudtuples_s3" {
  zone_id = "${data.aws_route53_zone.cloudtuples.zone_id}"
  name    = "alb.${data.aws_route53_zone.cloudtuples.name}"
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

# alias to cloudfront domain name
resource "aws_route53_record" "cdn_cloudtuples_s3" {
  zone_id = "${data.aws_route53_zone.cloudtuples.zone_id}"
  name    = "cdn${random_id.suffix.hex}.${data.aws_route53_zone.cloudtuples.name}"
  type    = "A"

  alias {
    zone_id                = "${aws_cloudfront_distribution.site_distribution.hosted_zone_id}"
    name                   = "${aws_cloudfront_distribution.site_distribution.domain_name}"
  }
}
