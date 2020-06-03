variable "aws_region" {
  description = "The AWS region things are created in"
  default     = "us-east-1"
}

variable "vpc_id" {
  default = "vpc-83e0c5f9"
}

variable "ec2_admin_role_name" {
  description = "EC2 Admin role name"
  default = "EC2_adm"
}

variable "ami" {
  default = "ami-09d95fab7fff3776c"
}

variable "key_name" {
  default = "kp2"
}

variable "internal_networks" {
  type        = list(string)
  default     = ["172.31.0.0/16"]
  description = "Internal network CIDR blocks."
}
