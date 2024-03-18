module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "sg" {
  source        = "./modules/sg"
  vpc_id        = module.vpc.vpc_id
  kubernetes-sg = "some-value" # Replace "some-value" with the actual value if needed
  jenkins-sg    = "some-value" # Replace "some-value" with the actual value if needed
  docker-sg     = "some-value" # Replace "some-value" with the actual value if needed
  server-ports  = var.server-ports
}

module "kubernetes-master" {
  source        = "./modules/kubernetes-master"
  kubernetes_sg = module.sg.kubernetes_sg_id # Correct output reference
  subnets       = module.vpc.subnet_ids
}

module "kubernetes-slave" {
  source        = "./modules/kubernetes-slave"
  kubernetes_sg = module.sg.kubernetes_sg_id # Correct output reference
  subnets       = module.vpc.subnet_ids
}

module "docker-server" {
  source    = "./modules/docker-server"
  docker_sg = module.sg.docker_sg_id # Correct output reference
  subnets   = module.vpc.subnet_ids
}