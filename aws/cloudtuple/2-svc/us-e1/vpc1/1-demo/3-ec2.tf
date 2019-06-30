# web a
#==============================
resource "aws_instance" "web_a" {
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a"
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = data.terraform_remote_state.e1_shared.outputs.kp
  subnet_id                   = data.terraform_remote_state.e1_vpc1.outputs.private_172_18_10
  associate_public_ip_address = false
  user_data                   = file("./scripts/ec2/web.sh")

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  vpc_security_group_ids = [
    data.terraform_remote_state.e1_vpc1.outputs.launch_prv_sg,
  ]

  tags = {
    Name = "${var.name}web-a"
  }
}

resource "aws_route53_record" "web_a_cloudtuples_private" {
  zone_id = data.aws_route53_zone.cloudtuples_private.zone_id
  name    = "weba.east1.${data.aws_route53_zone.cloudtuples_private.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web_a.private_ip]
}

resource "aws_instance" "web_b" {
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1b"
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = data.terraform_remote_state.e1_shared.outputs.kp
  subnet_id                   = data.terraform_remote_state.e1_vpc1.outputs.private_172_18_11
  associate_public_ip_address = false
  user_data                   = file("./scripts/ec2/web.sh")

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  vpc_security_group_ids = [
    data.terraform_remote_state.e1_vpc1.outputs.launch_prv_sg,
  ]

  tags = {
    Name = "${var.name}web-b"
  }
}

resource "aws_route53_record" "web_b_cloudtuples_private" {
  zone_id = data.aws_route53_zone.cloudtuples_private.zone_id
  name    = "webb.east1.${data.aws_route53_zone.cloudtuples_private.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.web_b.private_ip]
}

# Server
#==============================
resource "aws_instance" "server" {
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1b"
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = data.terraform_remote_state.e1_shared.outputs.kp
  subnet_id                   = data.terraform_remote_state.e1_vpc1.outputs.private_172_18_11
  private_ip                  = "172.18.11.10"
  associate_public_ip_address = false
  user_data                   = file("./scripts/ec2/client.sh")

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  vpc_security_group_ids = [
    data.terraform_remote_state.e1_vpc1.outputs.ec2_prv_sg,
  ]

  tags = {
    Name = "${var.name}server"
  }
}

resource "aws_route53_record" "server_cloudtuples_private" {
  zone_id = data.aws_route53_zone.cloudtuples_private.zone_id
  name    = "server.east1.${data.aws_route53_zone.cloudtuples_private.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.server.private_ip]
}

output "--- server ---" {
  value = [
    "az:        ${aws_instance.server.availability_zone} ",
    "priv ip:   ${aws_instance.server.private_ip} ",
    "pub ip:    ${aws_instance.server.public_ip} ",
    "priv dns:  ${aws_instance.server.private_dns} ",
  ]
}

# Sandbox
#==============================
resource "aws_instance" "sandbox" {
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1c"
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = data.terraform_remote_state.e1_shared.outputs.kp
  subnet_id                   = data.terraform_remote_state.e1_vpc1.outputs.private_100_64_10
  associate_public_ip_address = false
  user_data                   = file("./scripts/ec2/aws.sh")

  #iam_instance_profile = "${aws_iam_instance_profile.ec2_iam_profile.name}"

  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  vpc_security_group_ids = [
    data.terraform_remote_state.e1_vpc1.outputs.ec2_prv_sg,
  ]
  tags = {
    Name = "${var.name}sandbox"
  }
}

resource "aws_route53_record" "sandbox_cloudtuples_private" {
  zone_id = data.aws_route53_zone.cloudtuples_private.zone_id
  name    = "sandbox.east1.${data.aws_route53_zone.cloudtuples_private.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.sandbox.private_ip]
}

output "--- sandbox ---" {
  value = [
    "az:        ${aws_instance.sandbox.availability_zone} ",
    "priv ip:   ${aws_instance.sandbox.private_ip} ",
    "pub ip:    ${aws_instance.sandbox.public_ip} ",
    "priv dns:  ${aws_instance.sandbox.private_dns} ",
  ]
}

