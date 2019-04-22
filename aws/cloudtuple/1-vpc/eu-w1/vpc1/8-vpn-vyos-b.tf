# VyOS Router B
#==============================
resource "aws_eip_association" "vyos_b" {
  instance_id   = "${aws_instance.vyos_b.id}"
  allocation_id = "${aws_eip.vyos_b.id}"
}

resource "aws_instance" "vyos_b" {
  instance_type          = "t2.micro"
  availability_zone      = "eu-west-1b"
  ami                    = "ami-99a70de0"
  key_name               = "${data.terraform_remote_state.w1_shared.kp}"
  vpc_security_group_ids = ["${aws_security_group.vyos_pub_sg.id}"]
  subnet_id              = "${aws_subnet.public_172_16_1.id}"
  private_ip             = "172.16.1.100"
  source_dest_check      = false
  user_data              = "${file("./scripts/vyos-b.sh")}"

  tags {
    Name = "${var.name}vyos-b"
  }
}

resource "aws_route53_record" "vyosb_cloudtuples_public" {
  zone_id = "${data.aws_route53_zone.cloudtuples_public.zone_id}"
  name    = "vyosb.west1.${data.aws_route53_zone.cloudtuples_public.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.vyos_b.public_ip}"]
}

output "--- vyos-b ---" {
  value = [
    "az:        ${aws_instance.vyos_b.availability_zone } ",
    "priv ip:   ${aws_instance.vyos_b.private_ip} ",
    "pub ip:    ${aws_instance.vyos_b.public_ip} ",
    "priv dns:  ${aws_instance.vyos_b.private_dns} ",
  ]
}

# ROUTES
#==============================
resource "aws_route" "private_gcp_vpn_route1_b" {
  route_table_id         = "${aws_route_table.private_rtb_b.id}"
  destination_cidr_block = "10.0.0.0/8"
  instance_id            = "${aws_instance.vyos_b.id}"
}

resource "aws_route" "private_gcp_vpn_route2_b" {
  route_table_id         = "${aws_route_table.private_rtb_b.id}"
  destination_cidr_block = "35.199.192.0/19"
  instance_id            = "${aws_instance.vyos_b.id}"
}

resource "aws_route" "private_gcp_vpn_route3_b" {
  route_table_id         = "${aws_route_table.private_rtb_b.id}"
  destination_cidr_block = "199.36.153.4/30"
  instance_id            = "${aws_instance.vyos_b.id}"
}

resource "aws_route" "public_gcp_vpn_route3_b" {
  route_table_id         = "${aws_route_table.public_rtb_b.id}"
  destination_cidr_block = "199.36.153.4/30"
  instance_id            = "${aws_instance.vyos_b.id}"
}

# OUTPUTS
#==============================
# vpn connection: vyos-b to gcp
#------------------------------
# to 'vpc' gcp vpc
output "vyosb_tunnel_address" {
  value = "${aws_eip.vyos_b.public_ip}"
}

output "vyosb_aws_tunnel_inside_address" {
  value = "${var.vyosb_aws_tunnel_inside_address}"
}

output "vyosb_gcp_tunnel_inside_address" {
  value = "${var.vyosb_gcp_tunnel_inside_address}"
}

# to 'untrust' gcp vpc
output "vyosb_aws_tunnel_inside_address2" {
  value = "${var.vyosb_aws_tunnel_inside_address2}"
}

output "vyosb_gcp_tunnel_inside_address2" {
  value = "${var.vyosb_gcp_tunnel_inside_address2}"
}
