
data "aws_ami" "al2023-ami-2023" {
  owners           = var.amifilter["owner"]
  #name_regex       = "^ami-[0-9a-z]{16}[0-9a-z]$"
  most_recent      = true

  filter {
    name   = "name"
    values = var.amifilter["name"]
  }

  filter {
    name   = "virtualization-type"
    values = var.amifilter["virtualtype"]
  }

  filter {
    name   = "architecture"
    values = var.amifilter["arch"]
  }

  filter {
    name   = "root-device-type"
    values = var.amifilter["rootdevice"]
  }

}


resource "aws_instance" "web" {
  ami           = data.aws_ami.al2023-ami-2023.id
  instance_type = var.instancetype
  subnet_id     = "subnet-0ed425f53f5718034"
  associate_public_ip_address = var.ipassociate
  monitoring    = var.monitor
  key_name = var.keypair

  security_groups = [
        "${aws_security_group.sg.id}"
    ]
  
  root_block_device {
    #device_name = "/dev/xvda"          #(for ebs_block_device)
    delete_on_termination = var.volumedetails["delete_with_instance"]
    volume_type = var.volumedetails["type"]
    volume_size = var.volumedetails["size"]

    # tags = {
    #         Name = "instance-01a /dev/xvda"
    #     }

  }

  tags = {
    Name = var.instanceName
  }
}


