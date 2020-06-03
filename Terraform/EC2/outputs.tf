output "ec2_ip" {
  value = ["${aws_instance.ec2_adm.*.public_dns}"]
}
