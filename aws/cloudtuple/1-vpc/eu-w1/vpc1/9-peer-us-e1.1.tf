# VPC PEERING
#==============================
resource "aws_vpc_peering_connection" "w1_vpc1_to_e1_vpc1" {
  vpc_id        = "${aws_vpc.vpc1.id}"
  peer_region   = "us-east-1"
  peer_owner_id = "${var.peer_owner_id}"
  peer_vpc_id   = "${data.terraform_remote_state.e1_vpc1.vpc1}"

  tags {
    Name = "${var.name}to-e1.1"
    Side = "Requester"
  }
}

# ROUTES
#==============================
resource "aws_route" "w1_vpc1_a_to_e1_vpc1_a" {
  route_table_id            = "${aws_route_table.private_rtb_a.id}"
  destination_cidr_block    = "172.18.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.w1_vpc1_to_e1_vpc1.id}"
}

resource "aws_route" "w1_vpc1_b_to_e1_vpc1_b" {
  route_table_id            = "${aws_route_table.private_rtb_b.id}"
  destination_cidr_block    = "172.18.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.w1_vpc1_to_e1_vpc1.id}"
}

# OUTPUTS
#==============================

output "w1_vpc1_to_e1_vpc1" {
  value = "${aws_vpc_peering_connection.w1_vpc1_to_e1_vpc1.id}"
}
