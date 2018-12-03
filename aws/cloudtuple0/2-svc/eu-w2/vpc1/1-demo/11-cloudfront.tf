
# CDN DISTRIBUTION: S3 IMAGES REPO
#==============================
locals {
  s3_origin_id = "${var.name}cdn-img-origin"
}

resource "aws_cloudfront_distribution" "img_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.img.bucket_domain_name}"
    origin_id   = "${local.s3_origin_id}"
  }

  aliases = ["cdn.${var.domain_name}"]
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "bucket for cdn images"

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.img.bucket_domain_name}"
    prefix          = "${var.name}cf-img-logs"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
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
    viewer_protocol_policy = "https-only"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      #restriction_type = "whitelist"
      #locations        = ["US", "CA", "GB", "DE", "FR", "NL", "NG", "ES", "TT", "CH"]
    }
  }

  tags {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn = "${data.aws_acm_certificate.cdn_use1_cloudtuples.arn}"
    ssl_support_method  = "sni-only"
  }
}

# Alias to cloudfront domain name
resource "aws_route53_record" "cdn_cloudtuples_s3_img" {
  zone_id = "${data.aws_route53_zone.cloudtuples.zone_id}"
  name    = "cdn.${data.aws_route53_zone.cloudtuples.name}"
  type    = "A"

  alias {
    zone_id                = "${aws_cloudfront_distribution.img_distribution.hosted_zone_id}"
    name                   = "${aws_cloudfront_distribution.img_distribution.domain_name}"
    evaluate_target_health = false
  }
}
