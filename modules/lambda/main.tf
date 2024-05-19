provider "aws" {
  # we need to add required providers block since version is deprecated
  # version = "~> 5.0"
  region  = var.aws_region
}

resource "aws_iam_role" "lambda_execution_role" {
  #here we could also use a for_each and create lambdas in a dynamic fashion
  name = "${var.global_tags.environment}-${var.aws_region}-${var.lambda_s3_access.name}_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

resource "aws_iam_policy" "lambda_s3_access" {
  name = aws_iam_role.lambda_execution_role.name #var.lambda_s3_access.name
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject"],
        Resource = "arn:aws:s3:::${var.lambda_s3_access.name}/*",
        Effect   = "Allow"
      },
    ]
  })
}



resource "aws_iam_role_policy_attachment" "lambda_s3_access_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = aws_iam_policy.lambda_s3_access.arn
}

resource "aws_lambda_function" "lambda" {
  function_name = "${var.global_tags.environment}-${var.aws_region}-${var.lambda_s3_access.name}" #var.lambda_s3_access.name
  handler       = var.lambda_s3_access.handler
  role          = aws_iam_role.lambda_execution_role.arn
  # s3_bucket     = var.lambda_s3_access.name
  filename      = "${path.module}/${var.lambda_s3_access.lambda_zip_path}"
  runtime       = var.lambda_s3_access.runtime
  depends_on = [aws_iam_role_policy_attachment.lambda_s3_access_attachment]
}

