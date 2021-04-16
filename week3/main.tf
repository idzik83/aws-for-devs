terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

provider "aws" {
  profile = "idzik"
  region  = "us-west-2"
}

resource "aws_instance" "aws_4_dev_s3" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = data.template_file.init_script.rendered
  security_groups = [
    aws_security_group.aws_4_dev_sg_ssh.name,
  ]
  iam_instance_profile = aws_iam_instance_profile.aws_4_dev_profile.name
}

resource "aws_security_group" "aws_4_dev_sg_ssh" {
  name        = "aws_4_dev_sg_ssh"
  description = "Enable SSH access via port 22"
  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "rds" {
  source = "./modules/rds"
}

output "public_ip" {
  value = aws_instance.aws_4_dev_s3.public_ip
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}

output "rds_port" {
  value = module.rds.rds_port
}
