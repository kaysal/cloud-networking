# Private Zone
#==============================
resource "aws_route53_zone" "cloudtuples_private" {
  name    = "cloudtuples.com"
  comment = "eu-west-1 vpc2"

  vpc {
    vpc_id = aws_vpc.vpc2.id
  }
}

