resource "aws_iam_role" "aws_4_dev_s3_bucket_access" {
  name = "aws_4_dev_s3_bucket_access"
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


resource "aws_iam_role_policy" "aws_4_dev_s3_bucket_access_policy" {
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
  role = aws_iam_role.aws_4_dev_s3_bucket_access.id
}

resource "aws_iam_instance_profile" "aws_4_dev_profile" {
  name = "aws_4_dev_profile"
  role = aws_iam_role.aws_4_dev_s3_bucket_access.name
}
