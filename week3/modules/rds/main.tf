resource "aws_db_instance" "aws_4_dev_rds" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "13"
  instance_class       = "db.t3.micro"
  username             = var.rds_username
  password             = var.rds_user_pass
  skip_final_snapshot  = true
  security_group_names = [aws_security_group.ingress_rds.name]
}

resource "aws_security_group" "ingress_rds" {
  name = "ingress_rds"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
