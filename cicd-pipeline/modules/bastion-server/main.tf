resource "aws_instance" "bastion" {
  ami = var.ubuntu_ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  key_name = var.mykey
  vpc_security_group_ids = [var.bastion_sg]
  subnet_id = var.subnets[0]
  availability_zone = data.aws_availability_zones.available.names[0]
  user_data = filebase64("./userdata/bastion-setup.sh")
  
  tags = {
    Name =  var.instance_name
  }
}