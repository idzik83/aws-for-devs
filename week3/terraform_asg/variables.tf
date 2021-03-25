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

data "aws_availability_zones" "available" {
  state       = "available"
  filter {
    name = "region-name"
    values = ["us-west-2"]
  }
}
