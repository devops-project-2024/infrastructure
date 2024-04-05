resource "aws_instance" "jenkins-docker" {
  ami                         = var.ubuntu_ami
  key_name                    = var.mykey
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.docker_sg]
  subnet_id                   = var.subnets[0]
  availability_zone           = element(data.aws_availability_zones.available.names, 0)
  user_data = filebase64("./userdata/jenkins-docker.sh")

  tags = {
    Name = var.instance_name
  }
}

