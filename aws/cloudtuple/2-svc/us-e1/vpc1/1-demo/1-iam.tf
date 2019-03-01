resource "aws_iam_role" "ec2_role" {
  name               = "${var.name}ec2-role"
  assume_role_policy = "${file("./scripts/iam/ec2_role.json")}"
}

resource "aws_iam_role_policy" "s3_iam_policy" {
  name   = "${var.name}s3-policy"
  role   = "${aws_iam_role.ec2_role.id}"
  policy = "${file("./scripts/iam/s3_policy.json")}"
}

resource "aws_iam_instance_profile" "ec2_iam_profile" {
  name = "${var.name}ec2-iam-profile"
  role = "${aws_iam_role.ec2_role.name}"
}
