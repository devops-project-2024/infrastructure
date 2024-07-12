output "instances" {
  value = aws_instance.nexus.*.id
}

output "private_ips" {
  value = aws_instance.nexus.*.private_ip
  description = "List of private IP addresses assigned to the nexus host"
}

output "public_ips" {
  value = aws_instance.nexus.*.public_ip
  description = "List of public IP addresses assigned to the nexus host"
}
