module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "eks_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks_cluster_vpc"
  cidr = var.eks_vpc_cidr

  azs             = data.aws_availability_zones.azs.names
  public_subnets  = var.eks_public_subnets
  private_subnets = var.eks_private_subnets


  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1

  }
  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/private_elb"       = 1

  }
}

module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  cluster_name                   = "my-eks-cluster"
  cluster_version                = "1.29"
  cluster_endpoint_public_access = true
  vpc_id                         = module.eks_vpc.vpc_id
  subnet_ids                     = module.eks_vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size       = 1
      max_size       = 3
      desired_size   = 2
      instance_types = var.eks_instance_types
    }
  }
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

module "sg" {
  source        = "./modules/sg"
  vpc_id        = module.vpc.vpc_id
  kubernetes-sg = "some-value" # Replace "some-value" with the actual value if needed
  jenkins-sg    = "some-value" # Replace "some-value" with the actual value if needed
  docker-sg     = "some-value" # Replace "some-value" with the actual value if needed
  bastion-sg    = "some-value" # Replace "some-value" with the actual value if needed
  server-ports  = var.server-ports
}

# module "kubernetes-master" {
#   source        = "./modules/kubernetes-master"
#   kubernetes_sg = module.sg.kubernetes_sg_id # Correct output reference
#   subnets       = module.vpc.subnet_ids
#   key_name      = module.key_pair.key_name


# }

# module "kubernetes-slave" {
#   source        = "./modules/kubernetes-slave"
#   kubernetes_sg = module.sg.kubernetes_sg_id # Correct output reference
#   subnets       = module.vpc.subnet_ids
#   key_name      = module.key_pair.key_name
# }

module "docker-server" {
  source    = "./modules/docker-server"
  docker_sg = module.sg.docker_sg_id # Correct output reference
  subnets   = module.vpc.subnet_ids
  key_name  = module.key_pair.key_name
}

module "jenkins-docker" {
  source    = "./modules/jenkins-docker"
  docker_sg = module.sg.docker_sg_id # Correct output reference
  subnets   = module.vpc.subnet_ids
  key_name  = module.key_pair.key_name
}

module "bastion-server" {
  source     = "./modules/bastion-server"
  bastion_sg = module.sg.bastion_sg_id # Correct output reference
  subnets    = module.vpc.subnet_ids
  key_name   = module.key_pair.key_name
}

module "key_pair" {
  source   = "./modules/key_pair"
  key_name = "my-key-pair"
}
