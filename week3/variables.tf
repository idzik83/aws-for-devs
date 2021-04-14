variable "instance_type" {
  description = "Type of the AWS EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_ami" {
  description = "Amazon image id of the instance"
  type        = string
  default     = "ami-0ca5c3bd5a268e7db"
}

variable "key_name" {
  description = "Name of the key pair to be assigned to the instance"
  type        = string
  default     = "aws-for-dev"
}

variable "file_name" {
  description = "Name of the file to be downloaded from the bucket"
  type        = string
  default     = "some.txt"
}

variable "bucket_name" {
  description = "Name of s3 bucket"
  type        = string
  default     = "aws-4-dev-iidzikovskyi"
}

data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "region-name"
    values = ["us-west-2"]
  }
}


data "template_file" "init_script" {
  template = file("${path.module}/templates/init.tpl")

  vars = {
    bucket_name = var.bucket_name
    file_name   = var.file_name
  }
}
