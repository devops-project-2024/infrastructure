
output "jenkins_sg_id" {
  value = aws_security_group.jenkins_sg.id     # Ensure this resource is declared in this module
}

output "docker_sg_id" {
  value = aws_security_group.docker_sg.id      # Ensure this resource is declared in this module
}

output "nexus_sg_id" {
  value = aws_security_group.nexus_sg.id      # Ensure this resource is declared in this module
}