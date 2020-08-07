output "ec2_ip" {
  value = ["${aws_instance.aws_instance_sessions_manager.*.public_dns}"]
}
