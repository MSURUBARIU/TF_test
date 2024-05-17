provider "aws" {
  version = "~> 5.0"
  region  = var.aws_region
}

resource "aws_iam_role" "lambda_execution_role" {
  name = "${var.lambda_function_name}_execution_role"

  assume_role_policy = jsonecode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts::AssumeRole"
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
  name   = "${var.lambda_function_name}_s3_access"
  policy = jsonecode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:GetObject", "s3:PutObject"],
        Resource = "arn:aws::s3:::${var.s3_bucket_name}/*",
        Effect   = "Allow"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3_access_attachment" {
  role       = aws_iam_role.lambda-execution_role.name
  policy_arn = aws_iam_policy.lambda_s3_access.arns
}

resource "aws_lambda_function" "lambda" {
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  role          = aws_iam_role.lambda_execution_role.arns
  runtime       = var.runtime
  s3_bucket     = var.s3_bucket_name
  s3_key        = var.lambda_zip_path

  depends_on = [aws_iam_role_policy_attachment.lambda_s3_access_attachment]
}

