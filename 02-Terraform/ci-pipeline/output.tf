output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "subnet_ids" {
  description = "List of subnet IDs"
  value       = module.vpc.subnet_ids
}

output "docker_server_private_ip" {
  description = "Private IP addresses of Docker server instances"
  value       = module.docker-server.private_ips # Ensure your module outputs this attribute
}

output "docker_server_public_ip" {
  description = "Public IP addresses of Docker server instances"
  value       = module.docker-server.public_ips # Ensure your module outputs this attribute
}

output "Jenkins_server_private_ip" {
  description = "Private IP addresses of Kubernetes master instances"
  value       = module.jenkins-docker.private_ips # Ensure your module outputs this attribute
}

output "Jenkins_server_public_ip" {
  description = "Public IP addresses of Kubernetes master instances"
  value       = module.jenkins-docker.public_ips # Ensure your module outputs this attribute
}

# output "nexus_server_private_ip" {
#   description = "Private IP addresses of Kubernetes slave instances"
#   value       = module.nexus-server.private_ips # Ensure your module outputs this attribute
# }

# output "nexus_server_public_ip" {
#   description = "Public IP addresses of Kubernetes slave instances"
#   value       = module.nexus-server.public_ips # Ensure your module outputs this attribute
# }

output "security_group_jenkins" {
  description = "The ID of the Jenkins security group"
  value       = module.sg.jenkins_sg_id
}

output "security_group_docker" {
  description = "The ID of the Docker security group"
  value       = module.sg.docker_sg_id
}

output "security_group_nexus" {
  description = "The ID of the Docker security group"
  value       = module.sg.nexus_sg_id
}

output "created_key_name" {
  value = module.key_pair.key_name
}