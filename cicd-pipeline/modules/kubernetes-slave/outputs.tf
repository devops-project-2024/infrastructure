output "instances" {
  value = aws_instance.kubernetes-slave.*.id
}
output "private_ips" {
  description = "List of private IP addresses of Kubernetes master instances"
  value       = aws_instance.kubernetes-slave.*.private_ip
}

output "public_ips" {
  description = "List of public IP addresses of Kubernetes master instances"
  value       = aws_instance.kubernetes-slave.*.public_ip
}
