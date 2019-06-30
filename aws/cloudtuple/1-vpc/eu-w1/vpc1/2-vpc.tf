# VPC
#==============================
resource "aws_vpc" "vpc1" {
  cidr_block                       = var.vpc1_cidr
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = {
    Name = "${var.name}vpc1"
  }
}

# dhcp options
resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name         = "west1.cloudtuples.com"
  domain_name_servers = ["172.16.10.100", "AmazonProvidedDNS"]

  tags = {
    Name = "${var.name}dhcp-options"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.vpc1.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
}

# SUBNETS
#==============================
# public subnets
resource "aws_subnet" "public_172_16_0" {
  availability_zone       = "eu-west-1a"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.public_172_16_0
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 0)
  map_public_ip_on_launch = true

  tags = {
    Name  = "${var.name}public-172-16-0"
    Scope = "public"
  }
}

resource "aws_subnet" "public_172_16_1" {
  availability_zone       = "eu-west-1b"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.public_172_16_1
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 1)
  map_public_ip_on_launch = true

  tags = {
    Name  = "${var.name}public-172-16-1"
    Scope = "public"
  }
}

# private subnets
resource "aws_subnet" "private_172_16_10" {
  availability_zone       = "eu-west-1a"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.private_172_16_10
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 10)
  map_public_ip_on_launch = false

  tags = {
    Name  = "${var.name}private-172-16-10"
    Scope = "private"
  }
}

resource "aws_subnet" "private_172_16_11" {
  availability_zone       = "eu-west-1b"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.private_172_16_11
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 11)
  map_public_ip_on_launch = false

  tags = {
    Name  = "${var.name}private-172-16-11"
    Scope = "private"
  }
}

# Elastic IPs
resource "aws_eip" "vyos_a" {
  vpc                       = true
  associate_with_private_ip = "172.16.0.100"

  tags = {
    Name = "${var.name}vyos-a"
  }
}

resource "aws_eip" "vyos_b" {
  vpc                       = true
  associate_with_private_ip = "172.16.1.100"

  tags = {
    Name = "${var.name}vyos-b"
  }
}

# OUTPUTS
#==============================
output "vpc1" {
  value = aws_vpc.vpc1.id
}

output "public_172_16_0" {
  value = aws_subnet.public_172_16_0.id
}

output "public_172_16_1" {
  value = aws_subnet.public_172_16_1.id
}

output "private_172_16_10" {
  value = aws_subnet.private_172_16_10.id
}

output "private_172_16_11" {
  value = aws_subnet.private_172_16_11.id
}

# EXTERNAL DATA
#==============================
# capture local machine ipv4 to use in sec groups etc.
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

