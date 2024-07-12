resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key_file" {
  content  = tls_private_key.example.private_key_pem
  filename = "${path.module}/${var.key_name}.pem"
  #filename = "/tmp/${var.key_name}.pem"

  # Ensure the private key file is read/write by the owner only
  file_permission = "0600"
}