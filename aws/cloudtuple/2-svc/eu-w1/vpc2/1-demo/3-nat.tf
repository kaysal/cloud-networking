# NAT GATEWAYS
#==============================
# NAT instance for the private internal subnet
# ROUTES
#==============================
resource "aws_route" "private_internet_route_c" {
  route_table_id         = data.terraform_remote_state.w1_vpc2.outputs.private_rtb_c
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.appliance_inside.id
}

