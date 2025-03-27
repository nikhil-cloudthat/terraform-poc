# EC2 Instance Configurations
variable "instanceName" {
  type        = string
  default     = "terraform-instance"
  description = "Name of the instance"
}

variable "instancetype" {
  type        = string
  default     = "t2.micro"
  description = "Type of the instance"
}

variable "keypair" {
  type        = string
  default     = "jenkinskey"
  description = "Keypair Name"
}

variable "ipassociate" {
  type        = bool
  default     = true
  description = "Associate public IP address to Instance"
}

variable "monitor" {
  type        = bool
  default     = false
  description = "Monitoring of EC2 Instance (boolean: true/false)"
}

variable "volumedetails" { # Instance root volume details
  type = map
  default = {
    "size"                = 8
    "type"                = "gp3"
    "delete_with_instance" = true
  }
  description = "Root volume configuration options"
}

variable "amifilter" { # AMI filtering criteria
  type = map
  default = {
    "owner"        = ["amazon"]
    # "name"         = ["al2023-ami-2023.5.20240903.0-kernel-6.1-x86_64"]
    "virtualtype"  = ["hvm"]
    "arch"         = ["x86_64"]
    "rootdevice"   = ["ebs"]
  }
  description = "AMI filtering parameters"
}
