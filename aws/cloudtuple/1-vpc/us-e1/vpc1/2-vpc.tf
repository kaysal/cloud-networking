# VPC
#==============================
resource "aws_vpc" "vpc1" {
  cidr_block                       = "172.18.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags = {
    Name = "${var.name}vpc1"
  }
}

resource "aws_vpc_ipv4_cidr_block_association" "cgn_cidr" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "100.64.10.0/24"
}

# dhcp options
resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name         = "east1.cloudtuples.com"
  domain_name_servers = ["AmazonProvidedDNS"]

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
resource "aws_subnet" "public_172_18_0" {
  availability_zone       = "us-east-1a"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "172.18.0.0/24"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 0)
  map_public_ip_on_launch = true

  tags = {
    Name  = "${var.name}public-172-18-0"
    Scope = "public"
  }
}

resource "aws_subnet" "public_172_18_1" {
  availability_zone       = "us-east-1b"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "172.18.1.0/24"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 1)
  map_public_ip_on_launch = true

  tags = {
    Name  = "${var.name}public-172-18-1"
    Scope = "public"
  }
}

# private subnets
resource "aws_subnet" "private_172_18_10" {
  availability_zone       = "us-east-1a"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "172.18.10.0/24"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 10)
  map_public_ip_on_launch = false

  tags = {
    Name  = "${var.name}private-172-18-10"
    Scope = "private"
  }
}

resource "aws_subnet" "private_172_18_11" {
  availability_zone       = "us-east-1b"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "172.18.11.0/24"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 11)
  map_public_ip_on_launch = false

  tags = {
    Name  = "${var.name}private-172-18-11"
    Scope = "private"
  }
}

resource "aws_subnet" "private_172_18_12" {
  availability_zone       = "us-east-1c"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "172.18.12.0/24"
  ipv6_cidr_block         = cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 12)
  map_public_ip_on_launch = false

  tags = {
    Name  = "${var.name}private-172-18-12"
    Scope = "private"
  }
}

resource "aws_subnet" "private_100_64_10" {
  availability_zone       = "us-east-1c"
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "100.64.10.0/24"
  map_public_ip_on_launch = false

  tags = {
    Name  = "${var.name}private-100-64-10"
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
output "vpc1" {
  value = aws_vpc.vpc1.id
}

output "public_172_18_0" {
  value = aws_subnet.public_172_18_0.id
}

output "public_172_18_1" {
  value = aws_subnet.public_172_18_1.id
}

output "private_172_18_10" {
  value = aws_subnet.private_172_18_10.id
}

output "private_172_18_11" {
  value = aws_subnet.private_172_18_11.id
}

output "private_100_64_10" {
  value = aws_subnet.private_100_64_10.id
}

# EXTERNAL DATA
#==============================
# capture local machine ipv4 to use in sec groups etc.
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

