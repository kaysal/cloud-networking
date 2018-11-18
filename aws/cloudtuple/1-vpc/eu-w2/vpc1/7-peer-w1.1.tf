# VPC PEERING
#==============================
resource "aws_vpc_peering_connection_accepter" "w2_vpc1_to_w1_vpc1" {
  vpc_peering_connection_id = "${data.terraform_remote_state.w1_vpc1.w1_vpc1_to_w2_vpc1}"
  auto_accept               = true

  tags {
    Name = "${var.name}to-w1.1",
    Side = "Accepter"
  }
}

# ROUTES
#==============================
resource "aws_route" "w2_vpc1_a_to_w1_vpc1" {
  route_table_id         = "${aws_route_table.private_rtb_a.id}"
  destination_cidr_block = "172.16.0.0/16"
  vpc_peering_connection_id = "${data.terraform_remote_state.w1_vpc1.w1_vpc1_to_w2_vpc1}"
}

resource "aws_route" "w2_vpc1_b_to_w1_vpc1" {
  route_table_id         = "${aws_route_table.private_rtb_b.id}"
  destination_cidr_block = "172.16.0.0/16"
  vpc_peering_connection_id = "${data.terraform_remote_state.w1_vpc1.w1_vpc1_to_w2_vpc1}"
}
