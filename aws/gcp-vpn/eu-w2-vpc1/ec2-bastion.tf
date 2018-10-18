# elastic ips for instances
/*
resource "aws_eip" "ns01" {
  instance = "${aws_instance.ns01.id}"
  vpc      = true
}
*/
resource "aws_instance" "bastion" {
  instance_type          = "t2.micro"
  availability_zone = "eu-west-2a"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name_eu_west2}"
  vpc_security_group_ids = ["${aws_security_group.eu_w2_vpc1_bastion_sg.id}"]
  subnet_id              = "${aws_subnet.public_172_18_0.id}"
  private_ip = "172.18.0.10"
  associate_public_ip_address = true
  user_data = "${file("./scripts/bind.sh")}"

  tags {
    Name = "${var.name}bastion"
  }
}

output "--- bastion ---" {
  value = [
    "az:        ${aws_instance.bastion.availability_zone } ",
    "priv ip:   ${aws_instance.bastion.private_ip} ",
    "pub ip:    ${aws_instance.bastion.public_ip} ",
    "priv dns:  ${aws_instance.bastion.private_dns} ",
  ]
}
