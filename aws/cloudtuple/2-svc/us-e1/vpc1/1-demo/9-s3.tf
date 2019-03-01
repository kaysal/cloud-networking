# WEBSITE BUCKET
#==============================
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
  acl           = "private"

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
  source       = "./scripts/s3/index.html"
  etag         = "${md5(file("./scripts/s3/index.html"))}"
  content_type = "text/html"
}

resource "aws_s3_bucket_object" "error_html" {
  bucket       = "${aws_s3_bucket.site.bucket}"
  key          = "error.html"
  source       = "./scripts/s3/error.html"
  etag         = "${md5(file("./scripts/s3/error.html"))}"
  content_type = "text/html"
}

# CDN IMAGES BUCKET
#==============================
resource "aws_s3_bucket" "img" {
  bucket = "${var.bucket_img}"

  tags {
    Name = "${var.name}bucket-img"
  }

  force_destroy = true
  acl           = "private"

  policy = <<EOF
{
  "Id": "bucket_site_policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "bucket_img_policy_main",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${var.bucket_img}/*",
      "Principal": "*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_object" "aws_logo" {
  bucket       = "${aws_s3_bucket.img.bucket}"
  key          = "awsLogo.png"
  source       = "./scripts/cdn/awsLogo.png"
  etag         = "${md5(file("./scripts/s3/index.html"))}"
}

/*
# bucket 1
#==============================
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "${var.name}lambda-bucket"
  acl           = "private"
  force_destroy = true

  tags {
    Name = "${var.name}lambda-bucket"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = "${aws_s3_bucket.lambda_bucket.bucket}"
  key    = "reminder_service.py"

  content = <<EOF
import boto3

sns = boto3.client('sns')

def handler(event,context):
    sns.publish(
        TopicArn='${aws_sns_topic.user_updates.arn}',
        Message=(
            'Hello!'
            'Your children are not your children!'
            'They are the sons and daughters of Life\'s longing for itself'
        )
    )
    return 'success'
EOF
}

/*
resource "aws_s3_bucket_object" "error_html" {
  bucket       = "${aws_s3_bucket.site.bucket}"
  key          = "error.html"
  source       = "~/tf/aws/CERT/associate/scripts/error.html"
  etag         = "${md5(file("~/tf/aws/CERT/associate/scripts/error.html"))}"
  content_type = "text/html"
}*/
