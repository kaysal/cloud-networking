resource "aws_s3_bucket" "site" {
  bucket = "${var.bucket_site}"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags {
    Name = "${var.name}bucket-site"
  }

  force_destroy = true

  policy = <<EOF
{
  "Id": "bucket_site_policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_site_policy_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.bucket_site}/*",
      "Principal": "*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_object" "index_html" {
  bucket       = "${aws_s3_bucket.site.bucket}"
  key          = "index.html"
  source       = "~/tf/aws/CERT/associate/scripts/index.html"
  etag         = "${md5(file("~/tf/aws/CERT/associate/scripts/index.html"))}"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "error_html" {
  bucket       = "${aws_s3_bucket.site.bucket}"
  key          = "error.html"
  source       = "~/tf/aws/CERT/associate/scripts/error.html"
  etag         = "${md5(file("~/tf/aws/CERT/associate/scripts/error.html"))}"
  content_type = "text/html"
}
