resource "aws_launch_template" "launch_templ" {
  name = "${var.name}launch-templ"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 20
    }
  }

  disable_api_termination              = false
  image_id                             = data.aws_ami.ubuntu.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type                        = "t2.micro"
  key_name                             = data.terraform_remote_state.e1_shared.outputs.kp
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibilty in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  vpc_security_group_ids = [data.terraform_remote_state.e1_vpc1.outputs.launch_prv_sg]
  user_data              = base64encode(file("./scripts/ec2/launch.sh"))

  monitoring {
    enabled = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name}launch-templ"
    }
  }
}

