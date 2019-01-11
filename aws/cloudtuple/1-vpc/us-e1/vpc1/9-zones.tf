# Private Zone
#==============================
resource "aws_route53_zone" "cloudtuples_private" {
  name = "cloudtuples.com"
  comment = "us-east-1 vpc1"

  vpc {
    vpc_id = "${aws_vpc.vpc1.id}"
  }
}

# zone for restrcited.googleapis.com
resource "aws_route53_zone" "googleapis" {
  name = "googleapis.com"
  comment = "googleapis us-east1 vpc1"

  vpc {
    vpc_id = "${aws_vpc.vpc1.id}"
  }
}
