variable "docker_sg" {
  description = "SG ID for EC2"
  type = string
}

variable "subnets" {
  description = "Subnets for EC2"
  type = list(string)
}

variable "mykey" {
    description = "Key pair"
    type = string
    default = "acloud-key"
}

variable "instance_type" {
    description = "type of EC2 instance"
    type = string
    default = "t2.medium"
}

variable "instance_name" {
    description = "EC2 names"
    type = list(string)
    default = ["docker-nexus", "docker-sonarqube"]
}

variable "amazon_ami" {
   description = "Amazon Machine image - Amazon linux "
   default = "ami-026b57f3c383c2eec"
}
variable "redhat_ami"  {
  description = "Amazon Machine image - RedHat Enterprise Linux "
  default = "ami-026ebd4cfe2c043b2"
}
variable "ubuntu_ami" {
  description = "Amazon Machine image - Ubuntu"
  default = "ami-0fc5d935ebf8bc3bc"
} 
