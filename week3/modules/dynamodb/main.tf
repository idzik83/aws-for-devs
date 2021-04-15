resource "aws_dynamodb_table" "aws_4_dev_idzikovskyi" {
  hash_key = "ID"
  name = var.dynamo_table_name
  attribute {
    name = "ID"
    type = "S"
  }
}
