# Bastion
#==============================
resource "aws_instance" "bastion" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west2}"
  vpc_security_group_ids      = ["${data.terraform_remote_state.w2_vpc1.bastion_pub_sg}"]
  subnet_id                   = "${data.terraform_remote_state.w2_vpc1.public_172_18_0}"
  private_ip                  = "172.18.0.10"
  ipv6_address_count          = 1
  associate_public_ip_address = true
  user_data                   = "${file("./scripts/ec2/bastion.sh")}"

  tags {
    Name = "${var.name}bastion"
  }
}

resource "aws_route53_record" "bastion_cloudtuples_public" {
  zone_id = "${data.aws_route53_zone.cloudtuples.zone_id}"
  name    = "bastion.west2.${data.aws_route53_zone.cloudtuples.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.bastion.public_ip}"]
}

resource "aws_route53_record" "bastion_cloudtuples_private" {
  zone_id = "${data.aws_route53_zone.cloudtuples_private.zone_id}"
  name    = "bastion.west2.${data.aws_route53_zone.cloudtuples_private.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.bastion.private_ip}"]
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

# Web
#==============================
resource "aws_instance" "web" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west2}"
  subnet_id                   = "${data.terraform_remote_state.w2_vpc1.private_172_18_10}"
  private_ip                  = "172.18.10.10"
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/ec2/web.sh")}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.w2_vpc1.launch_prv_sg}",
  ]

  tags {
    Name = "${var.name}web"
  }
}

resource "aws_route53_record" "web_cloudtuples_private" {
  zone_id = "${data.aws_route53_zone.cloudtuples_private.zone_id}"
  name    = "web.west2.${data.aws_route53_zone.cloudtuples_private.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.web.private_ip}"]
}

output "--- web ---" {
  value = [
    "az:        ${aws_instance.web.availability_zone } ",
    "priv ip:   ${aws_instance.web.private_ip} ",
    "pub ip:    ${aws_instance.web.public_ip} ",
    "priv dns:  ${aws_instance.web.private_dns} ",
  ]
}

# Server
#==============================
resource "aws_instance" "server" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2b"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${var.key_name_eu_west2}"
  subnet_id                   = "${data.terraform_remote_state.w2_vpc1.private_172_18_11}"
  private_ip                  = "172.18.11.10"
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/ec2/client.sh")}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.w2_vpc1.ec2_prv_sg}",
  ]

  tags {
    Name = "${var.name}server"
  }
}

resource "aws_route53_record" "server_cloudtuples_private" {
  zone_id = "${data.aws_route53_zone.cloudtuples_private.zone_id}"
  name    = "server.west2.${data.aws_route53_zone.cloudtuples_private.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.server.private_ip}"]
}

output "--- server ---" {
  value = [
    "az:        ${aws_instance.server.availability_zone } ",
    "priv ip:   ${aws_instance.server.private_ip} ",
    "pub ip:    ${aws_instance.server.public_ip} ",
    "priv dns:  ${aws_instance.server.private_dns} ",
  ]
}

# Sandbox
#==============================
resource "aws_instance" "sandbox" {
  instance_type               = "t2.micro"
  availability_zone           = "eu-west-2c"
  ami                         = "${data.aws_ami.ami.id}"
  key_name                    = "${var.key_name_eu_west2}"
  subnet_id                   = "${data.terraform_remote_state.w2_vpc1.private_172_18_12}"
  private_ip                  = "172.18.12.10"
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/ec2/aws.sh")}"

  #iam_instance_profile = "${aws_iam_instance_profile.ec2_iam_profile.name}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.w2_vpc1.ec2_prv_sg}",
  ]
  tags {
    Name = "${var.name}sandbox"
  }
}

resource "aws_route53_record" "sandbox_cloudtuples_private" {
  zone_id = "${data.aws_route53_zone.cloudtuples_private.zone_id}"
  name    = "sandbox.west2.${data.aws_route53_zone.cloudtuples_private.name}"
  type    = "A"
  ttl     = "300"
  records = ["${aws_instance.sandbox.private_ip}"]
}

output "--- sandbox ---" {
  value = [
    "az:        ${aws_instance.sandbox.availability_zone } ",
    "priv ip:   ${aws_instance.sandbox.private_ip} ",
    "pub ip:    ${aws_instance.sandbox.public_ip} ",
    "priv dns:  ${aws_instance.sandbox.private_dns} ",
  ]
}
