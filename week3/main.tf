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
    aws_security_group.aws_4_dev_sg_http.name
  ]
  iam_instance_profile = aws_iam_instance_profile.aws_4_dev_profile.name
}

resource "aws_security_group" "aws_4_dev_sg_ssh" {
  name        = "aws_4_dev_sg_ssh"
  description = "Enable SSH access via port 22"
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "aws_4_dev_sg_http" {
  name        = "aws_4_dev_sg_http"
  description = "Enable HTTP access via port 80"
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = aws_instance.aws_4_dev_s3.public_ip
}

module "dynamodb" {
  source = "./modules/dynamodb"
}

module "rds" {
  source = "./modules/rds"
}
