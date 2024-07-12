module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "sg" {
  source        = "./modules/sg"
  vpc_id        = module.vpc.vpc_id
  jenkins-sg    = "some-value" # Replace "some-value" with the actual value if needed
  docker-sg     = "some-value" # Replace "some-value" with the actual value if needed
  nexus-sg      = "some-value" # Replace "some-value" with the actual value if needed
  kubernetes-sg = "some-value" # Replace "some-value" with the actual value if needed
  server-ports  = var.server-ports
}


module "docker-server" {
  source    = "./modules/docker-server"
  docker_sg = module.sg.docker_sg_id
  subnets   = module.vpc.subnet_ids
  key_name  = module.key_pair.key_name
}

module "jenkins-docker" {
  source    = "./modules/jenkins-docker"
  docker_sg = module.sg.docker_sg_id
  subnets   = module.vpc.subnet_ids
  key_name  = module.key_pair.key_name
}

# module "nexus-server" {
#   source   = "./modules/nexus-server"
#   nexus_sg = module.sg.nexus_sg_id
#   subnets  = module.vpc.subnet_ids
#   key_name = module.key_pair.key_name
# }

module "key_pair" {
  source   = "./modules/key_pair"
  key_name = "my-key-pair"
}
