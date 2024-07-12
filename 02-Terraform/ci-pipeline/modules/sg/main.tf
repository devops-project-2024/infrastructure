resource "aws_security_group" "jenkins_sg" {
  name        = "Jenkins-sg"
  description = "Allow HTTP, SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "SMTP"
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "SMTPS"
    from_port   = 465
    to_port     = 465
    protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Application Port"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Application Port"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Application Port"
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Application Port"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
   cidr_blocks = ["10.0.0.0/16"]
  }


  egress {
    description      = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins-sg"
  }
}

resource "aws_security_group" "docker_sg" {
  name        = "docker-sg"
  description = "Allow HTTP, SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description      = "Docker"
    from_port        = 3000 
    to_port          = 10000
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    description      = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "docker-sg"
  }
}

resource "aws_security_group" "nexus_sg" {
  name        = "nexus-sg"
  description = "Allow HTTP, SSH inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  } 

  ingress {
    description      = "Application port"
    from_port        = 8081
    to_port          = 8081
    protocol         = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  } 

  egress {
    description      = "egress"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nexus-sg"
  }
}