# Create VPC to launch our instances into
resource "aws_vpc" "vpc1_eu_w1" {
  cidr_block           = "${var.vpc1_eu_w1_cidr}"
  enable_dns_hostnames = "false"
  enable_dns_support   = "true"

  tags {
    Name = "${var.name}-vpc1-eu-w1"
  }
}

# Create subnets to launch instances into
resource "aws_subnet" "vpc1_eu_w1a_subnet" {
  availability_zone       = "eu-west-1a"
  vpc_id                  = "${aws_vpc.vpc1_eu_w1.id}"
  cidr_block              = "${var.vpc1_eu_w1a_subnet}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.name}-vpc1-eu-w1a-subnet"
  }
}

resource "aws_subnet" "vpc1_eu_w1b_subnet" {
  availability_zone       = "eu-west-1b"
  vpc_id                  = "${aws_vpc.vpc1_eu_w1.id}"
  cidr_block              = "${var.vpc1_eu_w1b_subnet}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.name}-vpc1-eu-w1b-subnet"
  }
}

# Create vpc internet gateway
resource "aws_internet_gateway" "vpc1_eu_w1_igw" {
  vpc_id = "${aws_vpc.vpc1_eu_w1.id}"

  tags {
    Name = "${var.name}-vpc1-eu-w1-igw"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "vpc1_eu_w1_igw_route" {
  route_table_id         = "${aws_vpc.vpc1_eu_w1.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.vpc1_eu_w1_igw.id}"
}

# Enable the VPGW to propagate BGP learned routes
# to the routing tables of a VPC
resource "aws_vpn_gateway_route_propagation" "vpc_vpgw_route_propagation" {
  vpn_gateway_id = "${aws_vpn_gateway.vpc1_eu_w1_vpgw.id}"
  route_table_id = "${aws_vpc.vpc1_eu_w1.main_route_table_id}"
}
