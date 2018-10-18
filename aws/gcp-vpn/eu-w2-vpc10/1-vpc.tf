# Create VPC to launch our instances into
resource "aws_vpc" "eu_w2_vpc1" {
  cidr_block           = "${var.eu_w2_vpc1_cidr}"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags {
    Name = "${var.name}eu-w2-vpc1"
  }
}

# Create subnets to launch instances into
resource "aws_subnet" "eu_w2_vpc1_172_18_10" {
  availability_zone       = "eu-west-2a"
  vpc_id                  = "${aws_vpc.eu_w2_vpc1.id}"
  cidr_block              = "${var.eu_w2_vpc1_172_18_10}"
  map_public_ip_on_launch = "false"

  tags {
    Name = "${var.name}eu-w2-vpc1-172-18-10"
  }
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh" ]
}

/*
# DHCP options
resource "aws_vpc_dhcp_options" "options" {
  domain_name          = "aws.cloudtuple.com"
  domain_name_servers  = ["172.18.10.100"]
  #ntp_servers          = ["127.0.0.1"]
  #netbios_name_servers = ["127.0.0.1"]
  #netbios_node_type    = 2

  tags {
    Name = "${var.name}dhcp-options"
  }
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.eu_w2_vpc1.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.options.id}"
}
*/
