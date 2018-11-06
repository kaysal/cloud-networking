# Create VPC to launch our instances into
resource "aws_vpc" "eu_w2_vpc1" {
  cidr_block                       = "${var.eu_w2_vpc1_cidr}"
  assign_generated_ipv6_cidr_block = true
  enable_dns_hostnames             = true
  enable_dns_support               = true

  tags {
    Name = "${var.name}eu-w2-vpc1"
  }
}

# Create subnets to launch instances into
resource "aws_subnet" "public_172_18_0" {
  availability_zone       = "eu-west-2a"
  vpc_id                  = "${aws_vpc.eu_w2_vpc1.id}"
  cidr_block              = "${var.public_172_18_0}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}public-172-18-0"
  }
}

resource "aws_subnet" "private_172_18_10" {
  availability_zone       = "eu-west-2a"
  vpc_id                  = "${aws_vpc.eu_w2_vpc1.id}"
  cidr_block              = "${var.private_172_18_10}"
  map_public_ip_on_launch = false

  tags {
    Name = "${var.name}private-172-18-10"
  }
}

# capture local machine ipv4 to use in security configuration
data "external" "onprem_ip" {
  program = ["sh", "scripts/onprem-ip.sh"]
}

resource "aws_vpc_peering_connection" "peer_to_eu_w1_vpc1" {
  vpc_id        = "${aws_vpc.eu_w2_vpc1.id}"
  peer_region   = "eu-west-1"
  peer_owner_id = "${var.peer_owner_id}"
  peer_vpc_id   = "${data.terraform_remote_state.eu_w1_vpc1.eu_w1_vpc1_id}"

  tags {
    Name = "peer: eu-w2-vpc1 & eu-w1-vpc1"
  }
}

# vpc flow log

# DHCP options
resource "aws_vpc_dhcp_options" "options" {
  domain_name          = "aws.cloudtuple.com"
  domain_name_servers  = ["172.18.10.100","AmazonProvidedDNS"]
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
