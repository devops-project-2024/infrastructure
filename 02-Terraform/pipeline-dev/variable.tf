variable "key_name" {}
variable "region" {}
variable "access_key" {}
variable "secret_key" {}
variable "instance_type" {
  description = "List of t2 instances"
}
variable "server-ports" {}
variable "agent-server" {
  description = "Agent server"
}
variable "artifactory-server" {
  description = "Store artifacts on the this artifactory server"
}
variable "cicd-server" {
  description = "Continoues Integration and deployment server "
}
variable "web-server" {
  description = "deploy web applications to this web server "
}
variable "qa-server" {
  description = "Qualitiy assurance server "
}
variable "amazon_ami" {
  description = "Amazon Machine image - Amazon linux "
}
variable "redhat_ami" {
  description = "Amazon Machine image - RedHat Enterprise Linux "
}
variable "ubuntu_ami" {
  description = "Amazon Machine image - Ubuntu"
}
variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type        = string
}
variable "subnet_cidr" {
  description = "Subnet CIDRS"
  type        = map(string)
}

variable "eks_vpc_cidr" {
  description = "Vpc CIDR"
  type        = string
}

variable "eks_public_subnets" {
  description = "public_subnets CIDR"
  type        = list(string)
}

variable "eks_private_subnets" {
  description = "private_subnets CIDR"
  type        = list(string)
}

variable "eks_instance_types" {
  description = "Node Instances"
  type        = list(string)
}