resource "aws_iam_role" "lambda_role" {
  name = "${var.name}lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.name}lambda-policy"
  role = "${aws_iam_role.lambda_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "sns:*"
      ],
      "Resource": "*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = "${var.name}lambda-function"
  filename         = "scripts/lambda_function.py.zip"
  role             = "${aws_iam_role.lambda_role.arn}"
  handler          = "lambda_function.handler"
  source_code_hash = "${base64sha256(file("scripts/lambda_function.py.zip"))}"
  runtime          = "python3.6"

  environment {
    variables = {
      key = "value"
    }
  }
}

resource "aws_cloudwatch_event_rule" "lambda_trigger_rule" {
  name        = "${var.name}lambda-trigger-rule"
  description = "Send annoying 1 minute notifications via sns"
  schedule_expression = "rate(1 minute)"
  is_enabled = true
}

resource "aws_cloudwatch_event_target" "lambda_event_target" {
  target_id = "whatever"
  rule      = "${aws_cloudwatch_event_rule.lambda_trigger_rule.name}"
  arn       = "${aws_lambda_function.lambda_function.arn}"
}

resource "aws_lambda_alias" "lambda_alias" {
  name             = "${var.name}lambda-alias"
  description      = "lambda alias"
  function_name    = "${aws_lambda_function.lambda_function.function_name}"
  function_version = "$LATEST"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id   = "AllowExecutionFromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.lambda_function.function_name}"
  principal      = "events.amazonaws.com"
  source_arn     = "${aws_cloudwatch_event_rule.lambda_trigger_rule.arn}"
  #qualifier      = "${aws_lambda_alias.lambda_alias.name}"
}
