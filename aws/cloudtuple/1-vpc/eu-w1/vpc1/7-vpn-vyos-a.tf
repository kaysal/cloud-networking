# VyOS Router A
#==============================
resource "aws_eip_association" "vyos_a" {
  instance_id   = "${aws_instance.vyos_a.id}"
  allocation_id = "${aws_eip.vyos_a.id}"
}

resource "aws_instance" "vyos_a" {
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1a"
  ami                    = "ami-99a70de0"
  key_name               = "${var.key_name_eu_west1}"
  vpc_security_group_ids = ["${aws_security_group.vyos_pub_sg.id}"]
  subnet_id              = "${aws_subnet.public_172_16_0.id}"
  private_ip             = "172.16.0.100"
  source_dest_check      = false
  user_data              = "${file("./scripts/vyos-a.sh")}"

  tags {
    Name = "${var.name}vyos-a"
  }
}

resource "aws_route53_record" "vyosa_cloudtuples_public" {
  zone_id = "${data.aws_route53_zone.cloudtuples_public.zone_id}"
  name    = "vyosa.west1.${data.aws_route53_zone.cloudtuples_public.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.vyos_a.public_ip}"]
}

output "--- vyos-a ---" {
  value = [
    "az:        ${aws_instance.vyos_a.availability_zone } ",
    "priv ip:   ${aws_instance.vyos_a.private_ip} ",
    "pub ip:    ${aws_instance.vyos_a.public_ip} ",
    "priv dns:  ${aws_instance.vyos_a.private_dns} ",
  ]
}

# ROUTES
#==============================
resource "aws_route" "private_gcp_vpn_route1_a" {
  route_table_id         = "${aws_route_table.private_rtb_a.id}"
  destination_cidr_block = "10.0.0.0/8"
  instance_id            = "${aws_instance.vyos_a.id}"
}

resource "aws_route" "private_gcp_vpn_route2_a" {
  route_table_id         = "${aws_route_table.private_rtb_a.id}"
  destination_cidr_block = "35.199.192.0/19"
  instance_id            = "${aws_instance.vyos_a.id}"
}

resource "aws_route" "private_gcp_vpn_route3_a" {
  route_table_id         = "${aws_route_table.private_rtb_a.id}"
  destination_cidr_block = "199.36.153.4/30"
  instance_id            = "${aws_instance.vyos_a.id}"
}

resource "aws_route" "public_gcp_vpn_route3_a" {
  route_table_id         = "${aws_route_table.public_rtb_a.id}"
  destination_cidr_block = "199.36.153.4/30"
  instance_id            = "${aws_instance.vyos_a.id}"
}

# OUTPUTS
#==============================
# vpn connection: vyos-a to gcp
#------------------------------
# to 'vpc' gcp vpc
output "vyosa_tunnel_address" {
  value = "${aws_eip.vyos_a.public_ip}"
}

output "vyosa_aws_tunnel_inside_address" {
  value = "${var.vyosa_aws_tunnel_inside_address}"
}

output "vyosa_gcp_tunnel_inside_address" {
  value = "${var.vyosa_gcp_tunnel_inside_address}"
}

# to 'untrust' gcp vpc
output "vyosa_aws_tunnel_inside_address2" {
  value = "${var.vyosa_aws_tunnel_inside_address2}"
}

output "vyosa_gcp_tunnel_inside_address2" {
  value = "${var.vyosa_gcp_tunnel_inside_address2}"
}
