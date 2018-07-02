# Create VPC to launch our instances into
resource "aws_vpc" "vpc1_us_e1" {
  cidr_block           = "${var.vpc1_us_e1_cidr}"
  enable_dns_hostnames = "false"
  enable_dns_support   = "true"

  tags {
    Name = "${var.name}-vpc1-us-e1"
  }
}

# Create subnets to launch instances into
resource "aws_subnet" "vpc1_us_e1b_subnet" {
  availability_zone       = "us-east-1b"
  vpc_id                  = "${aws_vpc.vpc1_us_e1.id}"
  cidr_block              = "${var.vpc1_us_e1b_subnet}"
  map_public_ip_on_launch = "true"

  tags {
    Name = "${var.name}-vpc1-us-e1b-subnet"
  }
}

# Create vpc internet gateway
resource "aws_internet_gateway" "vpc1_us_e1_igw" {
  vpc_id = "${aws_vpc.vpc1_us_e1.id}"

  tags {
    Name = "${var.name}-vpc1-us-e1-igw"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "vpc1_us_e1_igw_route" {
  route_table_id         = "${aws_vpc.vpc1_us_e1.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.vpc1_us_e1_igw.id}"
}

# Enable the VPGW to propagate BGP learned routes
# to the routing tables of a VPC
resource "aws_vpn_gateway_route_propagation" "vpc_vpgw_route_propagation" {
  vpn_gateway_id = "${aws_vpn_gateway.vpc1_us_e1_vpgw.id}"
  route_table_id = "${aws_vpc.vpc1_us_e1.main_route_table_id}"
}
