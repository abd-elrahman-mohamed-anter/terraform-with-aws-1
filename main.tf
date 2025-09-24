terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "<your region>"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow SSH, HTTP, and Flask traffic"
  vpc_id      = data.aws_vpc.default.id

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
    Name = "web-sg"
  }
}

resource "aws_instance" "my_ec2" {
  ami                    = "<your ami id>"
  instance_type          = "<your instance type>"
  key_name               = "<your key name>"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  availability_zone      = "<your availability zone>"

  user_data = file("userdata.sh")

  tags = {
    Name = "<your EC2 name>"
  }
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
