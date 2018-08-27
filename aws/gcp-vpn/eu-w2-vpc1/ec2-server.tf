resource "aws_instance" "client" {
  instance_type          = "t2.micro"
  availability_zone = "eu-west-2a"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name_eu_west2}"
  vpc_security_group_ids = ["${aws_security_group.eu_w2_vpc1_sec_grp.id}"]
  subnet_id              = "${aws_subnet.eu_w2_vpc1_172_18_10.id}"
  private_ip = "172.18.10.10"
  user_data = "${file("./scripts/client.sh")}"
  tags {
    Name = "${var.name}client"
  }
}

output "--- client ---" {
  value = [
    "az:        ${aws_instance.client.availability_zone } ",
    "priv ip:   ${aws_instance.client.private_ip} ",
    "pub ip:    ${aws_instance.client.public_ip} ",
    "priv dns:  ${aws_instance.client.private_dns} ",
  ]
}
