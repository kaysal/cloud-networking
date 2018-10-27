# Create VPN Gateway
#-----------------
resource "aws_vpn_gateway" "eu_w2_vpc1_vpgw" {
  vpc_id          = "${aws_vpc.eu_w2_vpc1.id}"
  amazon_side_asn = "${var.aws_side_asn}"

  tags {
    Name = "${var.name}eu-w2-vpc1-vpgw"
  }
}
