
# bastion server
#------------------------------
resource "aws_instance" "bastion" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west2}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.w2_vpc1.bastion_pub_sg}"]
  subnet_id                   = "${data.terraform_remote_state.w2_vpc1.public_172_18_0}"
  private_ip                  = "172.18.0.10"
  ipv6_address_count = 1
  associate_public_ip_address = true
  user_data                   = "${file("./scripts/bastion.sh")}"

  tags {
    Name = "${var.name}bastion"
  }
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

# name server
#------------------------------
resource "aws_instance" "ns01" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west2}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.w2_vpc1.ec2_prv_sg}"]
  subnet_id                   = "${data.terraform_remote_state.w2_vpc1.private_172_18_10}"
  private_ip                  = "172.18.10.100"
  ipv6_address_count = 1
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
    "priv ipv6: ${aws_instance.ns01.ipv6_addresses.0} ",
    "pub ip:    ${aws_instance.ns01.public_ip} ",
    "priv dns:  ${aws_instance.ns01.private_dns} ",
  ]
}

# test instance (server)
#------------------------------
resource "aws_instance" "server" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west2}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.w2_vpc1.ec2_prv_sg}"]
  subnet_id                   = "${data.terraform_remote_state.w2_vpc1.private_172_18_10}"
  private_ip                  = "172.18.10.10"
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
