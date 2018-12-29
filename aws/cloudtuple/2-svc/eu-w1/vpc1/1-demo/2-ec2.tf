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
  ipv6_address_count          = 1
  associate_public_ip_address = true
  user_data                   = "${file("./scripts/bastion.sh")}"
  tags {
    Name = "${var.name}bastion"
  }
}

# Public Zone Record
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

# Test aws-eu-west1
#==============================
resource "aws_instance" "aws_eu_west1" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1b"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west1}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.w1_vpc1.ec2_prv_sg}"]
  subnet_id                   = "${data.terraform_remote_state.w1_vpc1.private_172_16_11}"
  #private_ip                  = ""
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/client.sh")}"
  tags {
    Name = "${var.name}aws-eu-west1"
  }
}

output "--- aws-eu-west1 ---" {
  value = [
    "az:        ${aws_instance.aws_eu_west1.availability_zone } ",
    "priv ip:   ${aws_instance.aws_eu_west1.private_ip} ",
    "pub ip:    ${aws_instance.aws_eu_west1.public_ip} ",
    "priv dns:  ${aws_instance.aws_eu_west1.private_dns} ",
  ]
}
