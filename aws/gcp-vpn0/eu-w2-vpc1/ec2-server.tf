# elastic ips for instances
/*
resource "aws_eip" "server" {
  instance = "${aws_instance.server.id}"
  vpc      = true
}
*/

resource "aws_instance" "server" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west2}"
  vpc_security_group_ids      = ["${aws_security_group.eu_w2_vpc1_private_sg.id}"]
  subnet_id                   = "${aws_subnet.private_172_18_10.id}"
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
