# Create VPC to launch our instances into
resource "aws_vpc" "vpc" {
  cidr_block           = "192.168.0.0/16"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags {
    Name = "${var.name}vpc"
  }
}

# Create subnets to launch instances into
resource "aws_subnet" "subnet_1_public" {
  availability_zone       = "eu-west-2a"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "192.168.0.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}subnet-1-public"
  }
}

# Create subnets to launch instances into
resource "aws_subnet" "subnet_2_public" {
  availability_zone       = "eu-west-2b"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}subnet-2-public"
  }
}

resource "aws_subnet" "subnet_3_private" {
  availability_zone       = "eu-west-2a"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "192.168.4.0/23"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.name}subnet-3-private"
  }
}

# Create subnets to launch instances into
resource "aws_subnet" "subnet_4_private" {
  availability_zone       = "eu-west-2b"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "192.168.6.0/23"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.name}subnet-4-private"
  }
}
