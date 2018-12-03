resource "aws_flow_log" "vpc_flow_log" {
  log_destination = "${aws_cloudwatch_log_group.vpc_log_group.arn}"
  iam_role_arn    = "${aws_iam_role.vpc_log_role.arn}"
  vpc_id          = "${aws_vpc.vpc1.id}"
  traffic_type    = "ALL"
}

resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name = "${var.name}vpc-log-group"
}

resource "aws_iam_role" "vpc_log_role" {
  name = "${var.name}vpc-log-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "vpc_log_policy" {
  name = "${var.name}vpc-log-policy"
  role = "${aws_iam_role.vpc_log_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
