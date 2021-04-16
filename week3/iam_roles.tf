resource "aws_iam_role" "aws_4_dev_iam_role" {
  name = "aws_4_dev_iam_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "aws_4_dev_dynamodb_access_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:ListBucket", "s3:GetObject"]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::aws-4-dev-iidzikovskyi/*"
      },
    ]
  })
}

resource "aws_iam_policy" "aws_4_dev_s3_bucket_access_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "ListTables"
        Effect = "Allow"
        Action = "dynamodb:ListTables"
        Resource = "*"
      },
      {
        Sid   = "AWS4DevTable"
        Action = [
          "dynamodb:GetItem",
          "dynamodb:Query",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:BatchWriteItem"
        ]
        Effect   = "Allow"
        Resource = module.dynamodb.dynamodb_arn
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "aws_4_dev_dynamodb_access_policy" {
  policy_arn = aws_iam_policy.aws_4_dev_dynamodb_access_policy.arn
  role       = aws_iam_role.aws_4_dev_iam_role.name
}


resource "aws_iam_role_policy_attachment" "aws_4_dev_s3_bucket_access_policy_attachment" {
  policy_arn = aws_iam_policy.aws_4_dev_s3_bucket_access_policy.arn
  role       = aws_iam_role.aws_4_dev_iam_role.name
}

resource "aws_iam_instance_profile" "aws_4_dev_profile" {
  name = "aws_4_dev_w3_profile"
  role = aws_iam_role.aws_4_dev_iam_role.name
}
