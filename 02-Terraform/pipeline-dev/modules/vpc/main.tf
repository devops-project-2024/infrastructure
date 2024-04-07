# VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    tags = {
      "Name" = "my_vpc"
    }
}

# 2 Subnets
resource "aws_subnet" "subnets" {
  for_each = var.subnet_cidr
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = each.value
 availability_zone = data.aws_availability_zones.available.names[
    index(keys(var.subnet_cidr), each.key)
 ]
  tags = {
    Name = each.key
  }
}




# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # public 
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "MyRouteTable"
  }
}

# Route Table Association
resource "aws_route_table_association" "rta" {
  for_each = aws_subnet.subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.rt.id
}






# # VPC
# resource "aws_vpc" "my_vpc" {
#     cidr_block = var.vpc_cidr
#     instance_tenancy = "default"
#     tags = {
#         "Name" = "my_vpc"
#     }
# }

# # Subnets
# resource "aws_subnet" "public_subnet" {
#     vpc_id            = aws_vpc.my_vpc.id
#     cidr_block        = var.public_subnet_cidr
#     availability_zone = data.aws_availability_zones.available.names[0]
#     map_public_ip_on_launch = true # Automatically assign public IP on launch for instances in public subnet

#     tags = {
#         Name = "Public Subnet"
#     }
# }

# resource "aws_subnet" "private_subnet" {
#     vpc_id            = aws_vpc.my_vpc.id
#     cidr_block        = var.private_subnet_cidr
#     availability_zone = data.aws_availability_zones.available.names[1]

#     tags = {
#         Name = "Private Subnet"
#     }
# }

# # Internet Gateway
# resource "aws_internet_gateway" "igw" {
#     vpc_id = aws_vpc.my_vpc.id
#     tags = {
#         Name = "MyInternetGateway"
#     }
# }

# # Route Table for Public Subnet
# resource "aws_route_table" "public_rt" {
#     vpc_id = aws_vpc.my_vpc.id

#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = aws_internet_gateway.igw.id
#     }

#     tags = {
#         "Name" = "Public Route Table"
#     }
# }

# # Route Table Association for Public Subnet
# resource "aws_route_table_association" "public_rta" {
#     subnet_id      = aws_subnet.public_subnet.id
#     route_table_id = aws_route_table.public_rt.id
# }

# # Route Table for Private Subnet - no routes to the internet
# resource "aws_route_table" "private_rt" {
#     vpc_id = aws_vpc.my_vpc.id

#     tags = {
#         "Name" = "Private Route Table"
#     }
# }

# # Route Table Association for Private Subnet
# resource "aws_route_table_association" "private_rta" {
#     subnet_id      = aws_subnet.private_subnet.id
#     route_table_id = aws_route_table.private_rt.id
# }
