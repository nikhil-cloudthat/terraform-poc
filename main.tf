provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "web" {
  ami                         = "ami-076c6dbba59aa92e6"
  instance_type               = var.instancetype
  subnet_id                   = "subnet-0376b05408a1be5d4"
  associate_public_ip_address = var.ipassociate
  monitoring                  = var.monitor
  key_name                    = var.keypair

  security_groups = [aws_security_group.example_sg.id]

  root_block_device {
    delete_on_termination = var.volumedetails["delete_with_instance"]
    volume_type           = var.volumedetails["type"]
    volume_size           = var.volumedetails["size"]
  }

  tags = {
    Name = var.instanceName
  }
}


resource "aws_security_group" "example_sg" {
  name        = "terraform-poc-sg"
  description = "Security group for example services"
  vpc_id      = "vpc-0822634396310e8ea"

  # Ingress rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Egress rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-poc-sg"
  }
}
