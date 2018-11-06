resource "aws_launch_template" "launch_templ" {
  name = "${var.name}launch-templ"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  disable_api_termination              = false
  image_id                             = "${data.aws_ami.ubuntu.id}"
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  key_name                             = "${var.key_name_eu_west2}"
  vpc_security_group_ids               = ["${data.terraform_remote_state.w2_vpc1.launch_templ_prv_sg}"]
  user_data                            = "${base64encode(file("./scripts/script.sh"))}"

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags {
      Name = "${var.name}launch-templ"
    }
  }
}
