resource "aws_instance" "docker" {
  count                       = length(var.instance_name)
  ami                         = var.ubuntu_ami
  key_name                    = var.mykey
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.docker_sg]
  subnet_id                   = var.subnets[count.index]
  availability_zone           = data.aws_availability_zones.available.names[count.index]
  # user_data = filebase64("./userdata/install-docker.sh")
  
  tags = {
    Name = var.instance_name[count.index]
  }
}