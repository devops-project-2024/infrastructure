output "private_key" {
  description = "Private key in PEM format"
  value       = tls_private_key.example.private_key_pem
  sensitive   = true
}

output "public_key" {
  description = "Public key in OpenSSH format"
  value       = tls_private_key.example.public_key_openssh
}

output "key_name" {
  description = "Name of the AWS key pair"
  value       = aws_key_pair.generated_key.key_name
}