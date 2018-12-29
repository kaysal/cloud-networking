# name server ns01
#==============================
resource "aws_instance" "ns01" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west1}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.w1_vpc1.ec2_prv_sg}"]
  subnet_id                   = "${data.terraform_remote_state.w1_vpc1.private_172_16_10}"
  private_ip                  = "172.16.10.100"
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/bind.sh")}"

  tags {
    Name = "${var.name}ns01"
  }
}

output "--- name server ns01---" {
  value = [
    "az:        ${aws_instance.ns01.availability_zone } ",
    "priv ip:   ${aws_instance.ns01.private_ip} ",
    "pub ip:    ${aws_instance.ns01.public_ip} ",
    "priv dns:  ${aws_instance.ns01.private_dns} ",
  ]
}

# bastion server
#==============================
resource "aws_instance" "bastion" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west1}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.w1_vpc1.bastion_pub_sg}"]
  subnet_id                   = "${data.terraform_remote_state.w1_vpc1.public_172_16_0}"
  private_ip                  = "172.16.0.10"
  ipv6_address_count = 1
  associate_public_ip_address = true
  user_data                   = "${file("./scripts/bastion.sh")}"
  depends_on = ["aws_instance.ns01"]

  tags {
    Name = "${var.name}bastion"
  }
}

resource "aws_route53_record" "bastion_cloudtuples_public" {
  zone_id = "${data.aws_route53_zone.cloudtuples_public.zone_id}"
  name    = "bastion.west1.${data.aws_route53_zone.cloudtuples_public.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.bastion.public_ip}"]
}

output "--- bastion ---" {
  value = [
    "az:        ${aws_instance.bastion.availability_zone } ",
    "priv ip:   ${aws_instance.bastion.private_ip} ",
    "priv ipv6: ${aws_instance.bastion.ipv6_addresses.0} ",
    "pub ip:    ${aws_instance.bastion.public_ip} ",
    "priv dns:  ${aws_instance.bastion.private_dns} ",
  ]
}

# Server
#==============================
resource "aws_instance" "server" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1b"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west1}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.w1_vpc1.ec2_prv_sg}"]
  subnet_id                   = "${data.terraform_remote_state.w1_vpc1.private_172_16_11}"
  private_ip                  = "172.16.11.10"
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/client.sh")}"
  depends_on = ["aws_instance.ns01"]

  tags {
    Name = "${var.name}server"
  }
}

output "--- server ---" {
  value = [
    "az:        ${aws_instance.server.availability_zone } ",
    "priv ip:   ${aws_instance.server.private_ip} ",
    "pub ip:    ${aws_instance.server.public_ip} ",
    "priv dns:  ${aws_instance.server.private_dns} ",
  ]
}