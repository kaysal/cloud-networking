# VPC
#==============================
resource "aws_vpc" "vpc1" {
  cidr_block                       = "${var.vpc1_cidr}"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags {
    Name = "${var.name}vpc1"
  }
}

# dhcp options
resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name         = "west2.cloudtuples.com"
  domain_name_servers = ["AmazonProvidedDNS"]

  tags {
    Name = "${var.name}dhcp-options"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.vpc1.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dhcp_options.id}"
}

# SUBNETS
#==============================
# public subnets
resource "aws_subnet" "public_172_18_0" {
  availability_zone       = "eu-west-2a"
  vpc_id                  = "${aws_vpc.vpc1.id}"
  cidr_block              = "${var.public_172_18_0}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 0)}"
  map_public_ip_on_launch = true

  tags {
    Name  = "${var.name}public-172-18-0"
    Scope = "public"
  }
}

resource "aws_subnet" "public_172_18_1" {
  availability_zone       = "eu-west-2b"
  vpc_id                  = "${aws_vpc.vpc1.id}"
  cidr_block              = "${var.public_172_18_1}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 1)}"
  map_public_ip_on_launch = true

  tags {
    Name  = "${var.name}public-172-18-1"
    Scope = "public"
  }
}

# private subnets
resource "aws_subnet" "private_172_18_10" {
  availability_zone       = "eu-west-2a"
  vpc_id                  = "${aws_vpc.vpc1.id}"
  cidr_block              = "${var.private_172_18_10}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 10)}"
  map_public_ip_on_launch = false

  tags {
    Name  = "${var.name}private-172-18-10"
    Scope = "private"
  }
}

resource "aws_subnet" "private_172_18_11" {
  availability_zone       = "eu-west-2b"
  vpc_id                  = "${aws_vpc.vpc1.id}"
  cidr_block              = "${var.private_172_18_11}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 11)}"
  map_public_ip_on_launch = false

  tags {
    Name  = "${var.name}private-172-18-11"
    Scope = "private"
  }
}

resource "aws_subnet" "private_172_18_12" {
  availability_zone       = "eu-west-2c"
  vpc_id                  = "${aws_vpc.vpc1.id}"
  cidr_block              = "${var.private_172_18_12}"
  ipv6_cidr_block = "${cidrsubnet(aws_vpc.vpc1.ipv6_cidr_block, 8, 12)}"
  map_public_ip_on_launch = false

  tags {
    Name  = "${var.name}private-172-18-12"
    Scope = "private"
  }
}

# OUTPUTS
#==============================
output "vpc1" {
  value = "${aws_vpc.vpc1.id}"
}

output "public_172_18_0" {
  value = "${aws_subnet.public_172_18_0.id}"
}

output "public_172_18_1" {
  value = "${aws_subnet.public_172_18_1.id}"
}

output "private_172_18_10" {
  value = "${aws_subnet.private_172_18_10.id}"
}

output "private_172_18_11" {
  value = "${aws_subnet.private_172_18_11.id}"
}

output "private_172_18_12" {
  value = "${aws_subnet.private_172_18_12.id}"
}

# EXTERNAL DATA
#==============================
# capture local machine ipv4 to use in sec groups etc.
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}
