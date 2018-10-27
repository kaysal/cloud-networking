/*
# bucket 1
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

