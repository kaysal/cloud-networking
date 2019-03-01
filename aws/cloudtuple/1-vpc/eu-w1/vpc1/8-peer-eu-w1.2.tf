# VPC PEERING
#==============================
resource "aws_vpc_peering_connection" "w1_vpc1_to_w1_vpc2" {
  vpc_id        = "${aws_vpc.vpc1.id}"
  peer_region   = "eu-west-1"
  peer_owner_id = "${var.peer_owner_id}"
  peer_vpc_id   = "${data.terraform_remote_state.w1_vpc2.vpc2}"

  tags {
    Name = "${var.name}to-w1.2"
    Side = "Requester"
  }
}

# ROUTES
#==============================
resource "aws_route" "w1_vpc1_a_to_w1_vpc2" {
  route_table_id            = "${aws_route_table.private_rtb_a.id}"
  destination_cidr_block    = "172.17.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.w1_vpc1_to_w1_vpc2.id}"
}

resource "aws_route" "w1_vpc1_b_to_w1_vpc2" {
  route_table_id            = "${aws_route_table.private_rtb_b.id}"
  destination_cidr_block    = "172.17.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.w1_vpc1_to_w1_vpc2.id}"
}

# OUTPUTS
#==============================
output "w1_vpc1_to_w1_vpc2" {
  value = "${aws_vpc_peering_connection.w1_vpc1_to_w1_vpc2.id}"
}
