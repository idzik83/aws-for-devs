resource "aws_db_instance" "aws_4_dev_rds" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "13"
  instance_class       = "db.t3.micro"
  username             = var.rds_username
  password             = var.rds_user_pass
  skip_final_snapshot  = true
}