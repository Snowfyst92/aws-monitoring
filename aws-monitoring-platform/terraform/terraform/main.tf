# main.tf — Terraform pour créer une VM EC2 Ubuntu

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = "eu-west-3" # Paris
}

# Security group pour autoriser SSH + HTTP
resource "aws_security_group" "monitoring_sg" {
  name        = "monitoring-sg"
  description = "Allow SSH and HTTP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#key 
resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform-key"
  public_key = file("~/.ssh/terraform-key.pub")
}
# EC2 Ubuntu
resource "aws_instance" "monitoring_vm" {
  ami           = "ami-04df1508c6be5879e" # Ubuntu 22.04 LTS eu-west-3
  instance_type = "t3.micro"
  key_name = aws_key_pair.terraform_key.key_name  
  security_groups = [aws_security_group.monitoring_sg.name]

  tags = {
    Name = "Monitoring-VM"
  }
}
