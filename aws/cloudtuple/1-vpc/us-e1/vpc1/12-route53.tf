# Private Zone
#==============================
resource "aws_route53_zone" "cloudtuples_private" {
  name    = "cloudtuples.com"
  comment = "us-east-1 vpc1"

  vpc {
    vpc_id = "${aws_vpc.vpc1.id}"
  }
}

# zone for restrcited.googleapis.com
resource "aws_route53_zone" "googleapis" {
  name    = "googleapis.com"
  comment = "googleapis us-east1 vpc1"

  vpc {
    vpc_id = "${aws_vpc.vpc1.id}"
  }
}

# Route53 Endpoints
#==============================
resource "aws_route53_resolver_endpoint" "inbound_endpoint" {
  name               = "ks-us-e1-inbound-endpoint"
  direction          = "INBOUND"
  security_group_ids = ["${aws_security_group.ec2_prv_sg.id}"]

  ip_address {
    subnet_id = "${aws_subnet.private_172_18_10.id}"
    ip        = "172.18.10.100"
  }

  ip_address {
    subnet_id = "${aws_subnet.private_172_18_11.id}"
    ip        = "172.18.11.100"
  }

  tags {
    Environment = "Prod"
  }
}

resource "aws_route53_resolver_endpoint" "outbound_endpoint" {
  name               = "ks-us-e1-outbound-endpoint"
  direction          = "OUTBOUND"
  security_group_ids = ["${aws_security_group.ec2_prv_sg.id}"]

  ip_address {
    subnet_id = "${aws_subnet.private_172_18_10.id}"
  }

  ip_address {
    subnet_id = "${aws_subnet.private_172_18_11.id}"
  }

  tags {
    Environment = "Prod"
  }
}
