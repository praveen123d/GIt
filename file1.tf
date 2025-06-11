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
resource "aws_security_group" "ec2_sg" {
    name        = "ec2_sg"
    description = "Allow inbound SSH and HTTP"
    vpc_id      = null # Set this to your VPC ID if needed

    ingress {
        description = "SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "EC2SecurityGroup"
        Environment = "Development"
    }
}

resource "aws_instance" "ec2_instance1" {
    ami           = var.ami
    instance_type = var.instance_type

    vpc_security_group_ids = [aws_security_group.ec2_sg.id]

    tags = {
        Name = "EC2Instance1"
        Environment = "Development"
    }
}

resource "aws_s3_bucket" "name1" {
  bucket = "my-unique-bucket-name-12345" # Ensure this bucket name is globally unique
  acl    = "private"

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Development"
  }
  
}

