output "rds_arn" {
  value = aws_db_instance.aws_4_dev_rds.arn
}

output "rds_endpoint" {
  value = aws_db_instance.aws_4_dev_rds.endpoint
}

output "rds_port" {
  value = aws_db_instance.aws_4_dev_rds.port
}
