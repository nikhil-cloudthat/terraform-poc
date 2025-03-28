provider "aws" {
  region = "ap-south-1"
}

data "aws_security_group" "sg" {
  id = "sg-0021830d470bccf74"
}


resource "aws_instance" "web" {
  ami                         = "ami-076c6dbba59aa92e6"
  instance_type               = var.instancetype
  subnet_id                   = "subnet-0376b05408a1be5d4"
  associate_public_ip_address = var.ipassociate
  monitoring                  = var.monitor
  key_name                    = var.keypair

  security_groups = [data.aws_security_group.sg.id]

  root_block_device {
    delete_on_termination = var.volumedetails["delete_with_instance"]
    volume_type           = var.volumedetails["type"]
    volume_size           = var.volumedetails["size"]
  }

  tags = {
    Name = var.instanceName
  }
}
