resource "aws_autoscaling_group" "asg" {
  name             = "${var.name}asg"
  desired_capacity = 2
  max_size         = 5
  min_size         = 2

  target_group_arns = [
    "${aws_lb_target_group.asg_tg.arn}",
  ]

  launch_template = {
    id      = "${aws_launch_template.launch_templ.id}"
    version = "$$Latest"
  }

  vpc_zone_identifier = [
    "${data.terraform_remote_state.e1_vpc1.private_172_18_10}",
    "${data.terraform_remote_state.e1_vpc1.private_172_18_11}",
  ]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupMaxSize",
    "GroupInServiceInstances",
    "GroupPendingInstances",
  ]
}

resource "aws_autoscaling_policy" "asg-scale-up" {
  name                   = "${var.name}asg-scale-up"
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"

  # Step 1 (normal) - 70 <= CPUUtil < 85
  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 0
    metric_interval_upper_bound = 15
  }

  # Step 2 (spike) - 85 <= CPUUtil < +infinity
  step_adjustment {
    scaling_adjustment          = 2
    metric_interval_lower_bound = 15
  }
}

resource "aws_autoscaling_policy" "asg-scale-down" {
  name                   = "${var.name}asg-scale-down"
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
  policy_type            = "StepScaling"
  adjustment_type        = "ChangeInCapacity"

  # Step 1 (normal) - 40 <= CPUUtil < 50
  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_upper_bound = 0
    metric_interval_lower_bound = -10
  }

  # Step 2 (spike) - 50 >= CPUUtil < -infinity
  step_adjustment {
    scaling_adjustment          = -2
    metric_interval_upper_bound = -10
  }
}

/*
# simple austoscaling policy that ensures CPUUtil = 80%
# can be used in place of the scale-up and scale-down policies above
resource "aws_autoscaling_policy" "asg-policy" {
  name                   = "${var.name}asg-policy"
  autoscaling_group_name = "${aws_autoscaling_group.asg.name}"
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
}
*/

# CloudWatch alarm to increase ASG size when CPU Util >= 80%
resource "aws_cloudwatch_metric_alarm" "cpu-alarm-thresh-80-incr" {
  alarm_name                = "${var.name}cpu-alarm-thresh-80-incr"
  actions_enabled           = true
  alarm_actions             = ["${aws_autoscaling_policy.asg-scale-up.arn}"]
  statistic                 = "Average"
  metric_name               = "CPUUtilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  threshold                 = "70"
  evaluation_periods        = "1"
  period                    = "60"
  namespace                 = "AWS/EC2"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.asg.name}"
  }
}

# CloudWatch alarm to decrease ASG size when CPU Util < 50%
resource "aws_cloudwatch_metric_alarm" "cpu-alarm-thresh-50-decr" {
  alarm_name                = "${var.name}cpu-alarm-thresh-50-decr"
  actions_enabled           = true
  alarm_actions             = ["${aws_autoscaling_policy.asg-scale-down.arn}"]
  statistic                 = "Average"
  metric_name               = "CPUUtilization"
  comparison_operator       = "LessThanThreshold"
  threshold                 = "50"
  evaluation_periods        = "1"
  period                    = "60"
  namespace                 = "AWS/EC2"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.asg.name}"
  }
}
