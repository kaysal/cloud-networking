# Web
#==============================
resource "aws_instance" "web" {
  instance_type               = "t2.micro"
  availability_zone           = "us-east-1a"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${data.terraform_remote_state.e1_shared.kp}"
  subnet_id                   = "${data.terraform_remote_state.e1_vpc1.private_172_18_10}"
  private_ip                  = "172.18.10.10"
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/ec2/web.sh")}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.e1_vpc1.launch_prv_sg}",
  ]

  tags {
    Name = "${var.name}web"
  }
}

resource "aws_route53_record" "web_cloudtuples_private" {
  zone_id = "${data.aws_route53_zone.cloudtuples_private.zone_id}"
  name    = "web.east1.${data.aws_route53_zone.cloudtuples_private.name}"
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
  availability_zone           = "us-east-1b"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${data.terraform_remote_state.e1_shared.kp}"
  subnet_id                   = "${data.terraform_remote_state.e1_vpc1.private_172_18_11}"
  private_ip                  = "172.18.11.10"
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/ec2/client.sh")}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.e1_vpc1.ec2_prv_sg}",
  ]

  tags {
    Name = "${var.name}server"
  }
}

resource "aws_route53_record" "server_cloudtuples_private" {
  zone_id = "${data.aws_route53_zone.cloudtuples_private.zone_id}"
  name    = "server.east1.${data.aws_route53_zone.cloudtuples_private.name}"
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
  availability_zone           = "us-east-1c"
  ami                         = "${data.aws_ami.ubuntu.id}"
  key_name                    = "${data.terraform_remote_state.e1_shared.kp}"
  subnet_id                   = "${data.terraform_remote_state.e1_vpc1.private_100_64_10}"
  associate_public_ip_address = false
  user_data                   = "${file("./scripts/ec2/aws.sh")}"

  #iam_instance_profile = "${aws_iam_instance_profile.ec2_iam_profile.name}"

  vpc_security_group_ids = [
    "${data.terraform_remote_state.e1_vpc1.ec2_prv_sg}",
  ]
  tags {
    Name = "${var.name}sandbox"
  }
}

resource "aws_route53_record" "sandbox_cloudtuples_private" {
  zone_id = "${data.aws_route53_zone.cloudtuples_private.zone_id}"
  name    = "sandbox.east1.${data.aws_route53_zone.cloudtuples_private.name}"
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
