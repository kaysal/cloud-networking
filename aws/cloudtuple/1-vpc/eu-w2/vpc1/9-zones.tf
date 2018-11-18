# Private Zone
#==============================
resource "aws_route53_zone" "cloudtuples_private" {
  name = "cloudtuples.com"
  comment = "eu-west-2 vpc1"

  vpc {
    vpc_id = "${aws_vpc.vpc1.id}"
  }
}
