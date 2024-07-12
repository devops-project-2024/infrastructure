# resource "aws_instance" "nexus" {
#   ami                       = var.redhat_ami
#   instance_type             = var.instance_type
#   associate_public_ip_address = true
#   # key_name                  = module.key_pair.key_name  # Reference the key name from the module
#   key_name = var.key_name
#   vpc_security_group_ids    = [var.nexus_sg]
#   subnet_id                 = var.subnets[0]
#   availability_zone         = data.aws_availability_zones.available.names[0]
#   user_data                 = filebase64("./userdata/install-nexus.sh")
  
#   tags = {
#     Name = var.instance_name
#   }
# }

resource "aws_instance" "nexus" {
  ami                         = var.redhat_ami
  instance_type               = var.instance_type
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.nexus_sg]
  subnet_id                   = var.subnets[0]
  availability_zone           = data.aws_availability_zones.available.names[0]
  user_data                   = filebase64("./userdata/install-nexus.sh")
  monitoring                  = true
  ebs_optimized               = true

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = var.instance_name
  }
  
  metadata_options {
    http_tokens = "required"
  }
}
