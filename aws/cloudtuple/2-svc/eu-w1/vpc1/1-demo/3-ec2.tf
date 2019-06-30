# Server
#==============================
resource "aws_instance" "server" {
  instance_type     = "t2.micro"
  availability_zone = "eu-west-1b"
  ami               = data.aws_ami.ubuntu.id
  key_name          = data.terraform_remote_state.w1_shared.outputs.kp
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  vpc_security_group_ids      = [data.terraform_remote_state.w1_vpc1.outputs.ec2_prv_sg]
  subnet_id                   = data.terraform_remote_state.w1_vpc1.outputs.private_172_16_11
  private_ip                  = "172.16.11.10"
  associate_public_ip_address = false
  user_data                   = file("./scripts/client.sh")
  tags = {
    Name = "${var.name}server"
  }
}

output "--- server ---" {
  value = [
    "az:        ${aws_instance.server.availability_zone} ",
    "priv ip:   ${aws_instance.server.private_ip} ",
    "pub ip:    ${aws_instance.server.public_ip} ",
    "priv dns:  ${aws_instance.server.private_dns} ",
  ]
}

