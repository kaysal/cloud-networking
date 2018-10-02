resource "aws_instance" "bastion" {
  instance_type          = "t2.micro"
  availability_zone = "eu-west-2b"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name_eu_west2}"
  vpc_security_group_ids = ["${aws_security_group.bastion.id}"]
  subnet_id              = "${aws_subnet.subnet_2_public.id}"
  associate_public_ip_address = true
  user_data = "${file("./scripts/bastion.sh")}"
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
