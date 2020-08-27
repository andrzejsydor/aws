resource "aws_instance" "ec2_adm" {
  ami             = var.ami
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [aws_security_group.bastion.name]
  iam_instance_profile = "EC2_adm"
  count = "1"

  user_data = <<-EOT
    #!/bin/bash
    sudo yum update -y
  EOT

  root_block_device {
    delete_on_termination = true
  }

  tags = {
    Name = "EC2-${count.index}"
    Type = "EC2"
    Project = "test"
    Environment = "sandbox"
  }
}
