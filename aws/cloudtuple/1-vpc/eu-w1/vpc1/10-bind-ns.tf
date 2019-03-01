# name server ns01
#==============================
resource "aws_instance" "ns01" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west1}"
  vpc_security_group_ids      = ["${aws_security_group.ec2_prv_sg.id}"]
  subnet_id                   = "${aws_subnet.private_172_16_10.id}"
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
