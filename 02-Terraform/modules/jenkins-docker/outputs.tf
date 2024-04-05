output "instances" {
  value = aws_instance.jenkins-docker.*.id
}

output "private_ips" {
  description = "List of private IP addresses of Kubernetes master instances"
  value       = aws_instance.jenkins-docker.*.private_ip
}

output "public_ips" {
  description = "List of public IP addresses of Kubernetes master instances"
  value       = aws_instance.jenkins-docker.*.public_ip
}
