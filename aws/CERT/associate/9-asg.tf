resource "aws_autoscaling_group" "asg" {
  name = "${var.name}asg"
  target_group_arns = [
    "${aws_lb_target_group.target_grp.arn}",
  ]
  desired_capacity = 2
  max_size = 5
  min_size = 1

  launch_template = {
    id = "${aws_launch_template.launch_templ.id}"
    version = "$$Latest"
  }

  vpc_zone_identifier = [
    "${aws_subnet.subnet_3_private.id}",
    "${aws_subnet.subnet_4_private.id}"
  ]
}
