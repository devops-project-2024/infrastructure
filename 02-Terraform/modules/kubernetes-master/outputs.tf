output "instances" {
  value = aws_instance.kubernetes-master.*.id
}
output "private_ips" {
  description = "List of private IP addresses of Kubernetes master instances"
  value       = aws_instance.kubernetes-master.*.private_ip
}

output "public_ips" {
  description = "List of public IP addresses of Kubernetes master instances"
  value       = aws_instance.kubernetes-master.*.public_ip
}
