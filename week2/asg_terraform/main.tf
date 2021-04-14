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

resource "aws_autoscaling_group" "aws_4_dev_asg" {
  max_size         = 4
  min_size         = 2
  desired_capacity = 2
  launch_template {
    id      = aws_launch_template.aws_4_dev_lt.id
    version = "$Latest"
  }
  availability_zones = data.aws_availability_zones.available.names
}

resource "aws_launch_template" "aws_4_dev_lt" {
  image_id             = var.instance_ami
  instance_type        = var.instance_type
  key_name             = var.key_name
  user_data            = filebase64("${path.module}/scripts/startup.sh")
  security_group_names = [aws_security_group.aws_4_dev_sg.name]
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

output "iam_instance_profile" {
  value = aws_launch_template.aws_4_dev_lt.iam_instance_profile
}
