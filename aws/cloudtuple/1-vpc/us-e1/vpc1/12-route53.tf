# Private Zone
#==============================
resource "aws_route53_zone" "cloudtuples_private" {
  name    = "cloudtuples.com"
  comment = "us-east-1 vpc1"

  vpc {
    vpc_id = aws_vpc.vpc1.id
  }
}

# restrcited.googleapis.com
resource "aws_route53_zone" "googleapis" {
  name    = "googleapis.com"
  comment = "googleapis us-east1 vpc1"

  vpc {
    vpc_id = aws_vpc.vpc1.id
  }
}

resource "aws_route53_record" "googleapis" {
  zone_id = aws_route53_zone.googleapis.zone_id
  name    = "*.googleapis.com"
  type    = "CNAME"
  ttl     = "300"
  records = ["restricted.googleapis.com"]
}

resource "aws_route53_record" "restricted_googleapis" {
  zone_id = aws_route53_zone.googleapis.zone_id
  name    = "restricted.googleapis.com"
  type    = "A"
  ttl     = "300"

  records = [
    "199.36.153.7",
    "199.36.153.6",
    "199.36.153.4",
    "199.36.153.5",
  ]
}

# Route53 Endpoints
#==============================
resource "aws_route53_resolver_endpoint" "inbound_endpoint" {
  name               = "ks-us-e1-inbound-endpoint"
  direction          = "INBOUND"
  security_group_ids = [aws_security_group.ec2_prv_sg.id]

  ip_address {
    subnet_id = aws_subnet.private_172_18_10.id
    ip        = "172.18.10.100"
  }

  ip_address {
    subnet_id = aws_subnet.private_172_18_11.id
    ip        = "172.18.11.100"
  }

  tags = {
    Environment = "Prod"
  }
}

resource "aws_route53_resolver_endpoint" "outbound_endpoint" {
  name               = "ks-us-e1-outbound-endpoint"
  direction          = "OUTBOUND"
  security_group_ids = [aws_security_group.ec2_prv_sg.id]

  ip_address {
    subnet_id = aws_subnet.private_172_18_10.id
  }

  ip_address {
    subnet_id = aws_subnet.private_172_18_11.id
  }

  tags = {
    Environment = "Prod"
  }
}

# west1.cloudtuples rule
resource "aws_route53_resolver_rule" "eu_west1_cloudtuples_fwd" {
  domain_name          = "west1.cloudtuples.com"
  name                 = "west1-cloudtuples"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint.id

  target_ip {
    ip = "172.16.10.100"
  }

  tags = {
    Environment = "Prod"
  }
}

resource "aws_route53_resolver_rule_association" "eu_west1_cloudtuples_fwd" {
  resolver_rule_id = aws_route53_resolver_rule.eu_west1_cloudtuples_fwd.id
  vpc_id           = aws_vpc.vpc1.id
}

# apple.cloudtuple rule
resource "aws_route53_resolver_rule" "gcp_host_cloudtuple" {
  domain_name          = "host.cloudtuple.com"
  name                 = "gcp-host-cloudtuple"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint.id

  target_ip {
    ip = "10.250.10.2"
  }

  target_ip {
    ip = "10.150.10.2"
  }

  target_ip {
    ip = "10.100.10.40"
  }

  tags = {
    Environment = "Prod"
  }
}

resource "aws_route53_resolver_rule_association" "gcp_host_cloudtuple" {
  resolver_rule_id = aws_route53_resolver_rule.gcp_host_cloudtuple.id
  vpc_id           = aws_vpc.vpc1.id
}

# apple.cloudtuple rule
resource "aws_route53_resolver_rule" "gcp_apple_cloudtuple" {
  domain_name          = "apple.cloudtuple.com"
  name                 = "gcp-apple-cloudtuple"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint.id

  target_ip {
    ip = "10.250.10.2"
  }

  target_ip {
    ip = "10.150.10.2"
  }

  target_ip {
    ip = "10.100.10.40"
  }

  tags = {
    Environment = "Prod"
  }
}

resource "aws_route53_resolver_rule_association" "gcp_cloudtuple" {
  resolver_rule_id = aws_route53_resolver_rule.gcp_apple_cloudtuple.id
  vpc_id           = aws_vpc.vpc1.id
}

# mango.cloudtuple rule
resource "aws_route53_resolver_rule" "gcp_mango_cloudtuple" {
  domain_name          = "mango.cloudtuple.com"
  name                 = "gcp-mango-cloudtuple"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint.id

  target_ip {
    ip = "10.250.10.2"
  }

  target_ip {
    ip = "10.150.10.2"
  }

  target_ip {
    ip = "10.100.10.40"
  }

  tags = {
    Environment = "Prod"
  }
}

resource "aws_route53_resolver_rule_association" "gcp_mango_cloudtuple" {
  resolver_rule_id = aws_route53_resolver_rule.gcp_mango_cloudtuple.id
  vpc_id           = aws_vpc.vpc1.id
}

# orange.cloudtuple rule
resource "aws_route53_resolver_rule" "gcp_orange_cloudtuple" {
  domain_name          = "orange.cloudtuple.com"
  name                 = "gcp-orange-cloudtuple"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint.id

  target_ip {
    ip = "10.250.10.2"
  }

  target_ip {
    ip = "10.150.10.2"
  }

  target_ip {
    ip = "10.100.10.40"
  }

  tags = {
    Environment = "Prod"
  }
}

resource "aws_route53_resolver_rule_association" "gcp_orange_cloudtuple" {
  resolver_rule_id = aws_route53_resolver_rule.gcp_orange_cloudtuple.id
  vpc_id           = aws_vpc.vpc1.id
}

