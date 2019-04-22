# Server
#==============================
resource "aws_instance" "server" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-1b"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${data.terraform_remote_state.w1_shared.kp}"
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
