output "instances" {
  value = aws_instance.bastion.*.id
}

output "private_ips" {
  value = aws_instance.bastion.*.private_ip
  description = "List of private IP addresses assigned to the bastion host"
}

output "public_ips" {
  value = aws_instance.bastion.*.public_ip
  description = "List of public IP addresses assigned to the bastion host"
}
