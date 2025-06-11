variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

provider "aws" {
  region = var.aws_region
}

variable "ami" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  
}

variable "instance_type" {
  description = "The type of instance to use for the EC2 instance"
  type        = string
  default     = "t2.micro"
  
}


resource "aws_instance" "ec2_instance1" {
  ami           = var.ami # Example AMI ID, replace with a valid one
  instance_type = var.instance_type

  tags = {
    Name = "EC2Instance1"
    Environment = "Development"
}
}

