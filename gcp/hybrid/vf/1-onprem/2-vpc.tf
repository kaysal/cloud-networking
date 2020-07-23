
# vpc

resource "aws_vpc" "vpc" {
  cidr_block                       = var.onprem.vpc
  assign_generated_ipv6_cidr_block = "false"
  enable_dns_hostnames             = "true"
  enable_dns_support               = "true"

  tags = {
    Name = "${local.prefix}vpc1"
    ldap = "salawu"
  }
}

# dhcp options

resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name = "googleapis.com"
  domain_name_servers = [
    "AmazonProvidedDNS"
  ]

  tags = {
    Name = "${local.prefix}dhcp-options"
    ldap = "salawu"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
}

# public subnet

resource "aws_subnet" "pub_subnet_a" {
  availability_zone       = "${var.onprem.location}a"
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.onprem.subnet.pub.a
  map_public_ip_on_launch = true

  tags = {
    Name  = "${local.prefix}pub-subnet-a"
    Scope = "public"
    ldap  = "salawu"
  }
}

resource "aws_subnet" "pub_subnet_b" {
  availability_zone       = "${var.onprem.location}b"
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.onprem.subnet.pub.b
  map_public_ip_on_launch = true

  tags = {
    Name  = "${local.prefix}pub-subnet-b"
    Scope = "public"
    ldap  = "salawu"
  }
}

# private subnet

resource "aws_subnet" "prv_subnet_a" {
  availability_zone       = "${var.onprem.location}a"
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.onprem.subnet.prv.a
  map_public_ip_on_launch = false

  tags = {
    Name  = "${local.prefix}prv-subnet-a"
    Scope = "private"
    ldap  = "salawu"
  }
}

resource "aws_subnet" "prv_subnet_b" {
  availability_zone       = "${var.onprem.location}b"
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.onprem.subnet.prv.b
  map_public_ip_on_launch = false

  tags = {
    Name  = "${local.prefix}prv-subnet-b"
    Scope = "private"
    ldap  = "salawu"
  }
}
