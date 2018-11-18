# appliance
#==============================
resource "aws_instance" "appliance" {
  instance_type          = "t2.medium"
  availability_zone      = "eu-west-1c"
  ami                    = "ami-0ea87e2bfa81ca08a"
  key_name               = "${var.key_name_eu_west1}"
  subnet_id = "${data.terraform_remote_state.w1_vpc2.public_172_17_0}"
  private_ip             = "172.17.0.100"
  ipv6_address_count = 1
  vpc_security_group_ids = ["${data.terraform_remote_state.w1_vpc2.appliance_pub_sg}"]
  associate_public_ip_address  = true
  user_data = "${file("./scripts/appliance.sh")}"

  tags {
    Name = "${var.name}appliance"
  }
}

resource "aws_network_interface" "appliance_inside" {
  subnet_id = "${data.terraform_remote_state.w1_vpc2.private_172_17_10}"
  private_ips     = ["172.17.10.100"]
  source_dest_check = false
  security_groups = ["${data.terraform_remote_state.w1_vpc2.appliance_prv_sg}"]

  attachment {
    instance     = "${aws_instance.appliance.id}"
    device_index = 1
  }

  tags {
    ENI = "${var.name}appliance-dmz"
  }
}

# Public Zone Record
resource "aws_route53_record" "appliance_cloudtuples_public" {
  zone_id = "${data.aws_route53_zone.cloudtuples_public.zone_id}"
  name    = "appliance.west.${data.aws_route53_zone.cloudtuples_public.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.appliance.public_ip}"]
}

output "--- appliance ---" {
  value = [
    "az:        ${aws_instance.appliance.availability_zone } ",
    "priv ip:   ${aws_instance.appliance.private_ip} ",
    "priv ipv6: ${aws_instance.appliance.ipv6_addresses.0} ",
    "pub ip:    ${aws_instance.appliance.public_ip} ",
    "priv dns:  ${aws_instance.appliance.private_dns} ",
  ]
}

# test instance (web server)
#==============================
resource "aws_instance" "web" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1c"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west1}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.w1_vpc2.ec2_prv_sg}"]
  subnet_id                   = "${data.terraform_remote_state.w1_vpc2.private_172_17_10}"
  private_ip                  = "172.17.10.10"
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/web-server.sh")}"

  tags {
    Name = "${var.name}web"
  }

  depends_on = ["aws_instance.appliance"]
}

output "--- web ---" {
  value = [
    "az:        ${aws_instance.web.availability_zone } ",
    "priv ip:   ${aws_instance.web.private_ip} ",
    "pub ip:    ${aws_instance.web.public_ip} ",
    "priv dns:  ${aws_instance.web.private_dns} ",
  ]
}
