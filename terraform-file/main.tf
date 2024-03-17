module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}
module "sg" {
  source = "./modules/sg"
  sg = module.sg.sg
  server-ports = var.server-ports
  vpc_id = module.vpc.vpc_id
}

module "tomcat" {
  source = "./modules/tomcat"
  sg = module.sg.sg
  subnets = module.vpc.subnet_ids
}

module "nexus" {
  source = "./modules/nexus"
  sg = module.sg.sg
  subnets = module.vpc.subnet_ids
}
module "sonarqube" {
  source = "./modules/sonarqube"
  sg = module.sg.sg
  subnets = module.vpc.subnet_ids
}