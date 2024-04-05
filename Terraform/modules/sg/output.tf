output "kubernetes_sg_id" {
  value = aws_security_group.kubernetes_sg.id  # Ensure this resource is declared in this module
}

output "jenkins_sg_id" {
  value = aws_security_group.jenkins_sg.id     # Ensure this resource is declared in this module
}

output "docker_sg_id" {
  value = aws_security_group.docker_sg.id      # Ensure this resource is declared in this module
}

output "bastion_sg_id" {
  value = aws_security_group.bastion_sg.id      # Ensure this resource is declared in this module
}