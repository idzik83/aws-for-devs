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

resource "aws_launch_template" "aws_4_dev_lt" {
  image_id             = var.instance_ami
  instance_type        = var.instance_type
  key_name             = var.key_name
  user_data            = data.template_file.init_script.rendered
  security_group_names = [aws_security_group.aws_4_dev_sg.name]
  iam_instance_profile {
    name = aws_iam_instance_profile.aws_4_dev_profile.name
  }
}

resource "aws_security_group" "aws_4_dev_sg" {
  name        = "ssh_access"
  description = "Enable SSH access via port 22"
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "aws_4_dev_sg_http" {
  name        = "ssh_access"
  description = "Enable HTTP access via port 80"
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}
