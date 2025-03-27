provider "aws" {
  region = "ap-south-1"  # Replace with your region
}

variable "vpc_id" {
  description = "ID of the existing VPC"
  type        = string
  default     = "vpc-0822634396310e8ea"  # Replace with your VPC ID
}

variable "allowed_ssh_cidr" {
  description = "IP range allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Restrict this to specific IPs in production
}

resource "aws_security_group" "example_sg" {
  name        = "example-sg"
  description = "Security group for example services"
  vpc_id      = var.vpc_id

  # Ingress rules (SSH, HTTP, HTTPS)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
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

  # Egress rule (allow all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example-sg"
  }
}

output "security_group_id" {
  value = aws_security_group.example_sg.id
}
