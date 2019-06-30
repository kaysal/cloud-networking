# Bastion
#==============================
resource "aws_instance" "bastion" {
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a"
  ami                         = data.aws_ami.ubuntu.id
  key_name                    = data.terraform_remote_state.e1_shared.outputs.kp
  vpc_security_group_ids      = [aws_security_group.bastion_pub_sg.id]
  subnet_id                   = aws_subnet.public_172_18_0.id
  private_ip                  = "172.18.0.10"
  ipv6_address_count          = 1
  associate_public_ip_address = true
  user_data                   = file("./scripts/bastion.sh")

  tags = {
    Name = "${var.name}bastion"
  }
}

resource "aws_route53_record" "bastion_cloudtuples_public" {
  zone_id = data.aws_route53_zone.cloudtuples_public.zone_id
  name    = "bastion.east1.${data.aws_route53_zone.cloudtuples_public.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.bastion.public_ip]
}

resource "aws_route53_record" "bastion_cloudtuples_private" {
  zone_id = aws_route53_zone.cloudtuples_private.zone_id
  name    = "bastion.east1.${aws_route53_zone.cloudtuples_private.name}"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.bastion.private_ip]
}

output "--- bastion ---" {
  value = [
    "az:        ${aws_instance.bastion.availability_zone} ",
    "priv ip:   ${aws_instance.bastion.private_ip} ",
    "priv ipv6: ${aws_instance.bastion.ipv6_addresses[0]} ",
    "pub ip:    ${aws_instance.bastion.public_ip} ",
    "priv dns:  ${aws_instance.bastion.private_dns} ",
  ]
}

