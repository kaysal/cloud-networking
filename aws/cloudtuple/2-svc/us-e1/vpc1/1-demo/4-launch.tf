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
  key_name                             = "${data.terraform_remote_state.e1_shared.kp}"
  vpc_security_group_ids               = ["${data.terraform_remote_state.e1_vpc1.launch_prv_sg}"]
  user_data                            = "${base64encode(file("./scripts/ec2/launch.sh"))}"

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
