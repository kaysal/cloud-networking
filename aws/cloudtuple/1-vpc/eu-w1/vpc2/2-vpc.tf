# VPC
#==============================
resource "aws_vpc" "vpc2" {
  cidr_block                       = var.vpc2_cidr
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = {
    Name = "${var.name}vpc2"
  }
}

# dhcp options
resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name         = "west.cloudtuples.com"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags = {
    Name = "${var.name}dhcp-options"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.vpc2.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
}

# SUBNETS
#==============================
# public subnets
resource "aws_subnet" "public_172_17_0" {
  availability_zone       = "eu-west-1a"
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.public_172_17_0
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc2.ipv6_cidr_block, 8, 0)
  map_public_ip_on_launch = true

  tags = {
    Name  = "${var.name}public-172-17-0"
    Scope = "public"
  }
}

# private subnets
resource "aws_subnet" "private_172_17_10" {
  availability_zone       = "eu-west-1a"
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.private_172_17_10
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc2.ipv6_cidr_block, 8, 10)
  map_public_ip_on_launch = false

  tags = {
    Name  = "${var.name}private-172-17-10"
    Scope = "private"
  }
}

resource "aws_subnet" "private_172_17_12" {
  availability_zone       = "eu-west-1b"
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = var.private_172_17_12
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc2.ipv6_cidr_block, 8, 12)
  map_public_ip_on_launch = false

  tags = {
    Name  = "${var.name}private-172-17-12"
    Scope = "private"
  }
}

# Key Pair
resource "aws_key_pair" "ks_ec2" {
  key_name   = "ks-ec2"
  public_key = file(var.public_key_path)
}

# OUTPUTS
#==============================
output "vpc2" {
  value = aws_vpc.vpc2.id
}

output "vpc2_cidr" {
  value = aws_vpc.vpc2.cidr_block
}

output "public_172_17_0" {
  value = aws_subnet.public_172_17_0.id
}

output "private_172_17_10" {
  value = aws_subnet.private_172_17_10.id
}

