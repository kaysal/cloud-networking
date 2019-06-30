# VPC PEERING
#==============================
resource "aws_vpc_peering_connection_accepter" "w1_vpc2_to_w1_vpc1" {
  vpc_peering_connection_id = data.terraform_remote_state.w1_vpc1.outputs.w1_vpc1_to_w1_vpc2
  auto_accept               = true

  tags = {
    Name = "${var.name}to-w1.1"
    Side = "Accepter"
  }
}

# ROUTES
#==============================
resource "aws_route" "w1_vpc2_to_w1_vpc1_c" {
  route_table_id            = aws_route_table.private_rtb_c.id
  destination_cidr_block    = "172.16.0.0/16"
  vpc_peering_connection_id = data.terraform_remote_state.w1_vpc1.outputs.w1_vpc1_to_w1_vpc2
}

