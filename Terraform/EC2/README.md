```
tarraform init
terraform apply -auto-approve
terraform destroy -auto-approve
```

```
provider "aws" {
  profile    = "default"
  region     = "us-east-1"
}

resource "aws_instance" "ec1" {
  ami           = "ami-0323c3dd2da7fb37d"
  instance_type = "t2.micro"
  key_name      = "KEY-NAME"
  security_groups = ["SECURITY-GROUP-NAME"]
  count = "2"

  user_data = <<-EOT
    #!/bin/bash
    sudo yum update -y
    echo "test"
  EOT

  # provisioner "local-exec" {
    # command = "sudo yum update"
  # }

  # provisioner "remote-exec" {
  #   inline = [
  #     "sudo yum update",
  #     "echo 'abc'",
  #   ]
  # }

  tags = {
    Name = "EC2-${count.index}"
    Type = "EC2"
    Owner = "dev"
  }
}
```
