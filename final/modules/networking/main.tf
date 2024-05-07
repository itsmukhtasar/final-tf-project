# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}
#create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

#use data source to get all availability zones in region
data "aws_availability_zones" "available_zones" {}

 # Create public subnet 
resource "aws_subnet" "public" {
   count             = 3
  vpc_id            = aws_vpc.vpc.id
  #cidr_block        = var.public_subnet_cidr
  cidr_block        = var.public_subnets_cidr_blocks[count.index]

  availability_zone = data.aws_availability_zones.available_zones.names[count.index]
  

  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-public-subnet"
  }
}



# Create private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = data.aws_availability_zones.available_zones.names[0]
  tags = {
    Name = "${var.project_name}-private-subnet"
  }
}
resource "aws_eip" "nat" {
  domain = "vpc"
}

# Create NAT gateway

resource "aws_nat_gateway" "nat" {
  #count         = length(aws_subnet.public)
  allocation_id = aws_eip.nat.id
   subnet_id     = aws_subnet.public[0].id
  #allocation_id = aws_eip.nat[count.index].id
  #subnet_id     = aws_subnet.public[count.index].id 


  tags = {
    Name = "${var.project_name}-NAT-gw"
  }

  
  #depends_on = [aws_internet_gateway.example]
}




# Create route table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.project_name}-private-route-table"
  }
}

#Associate NAT gateway with private subnets
resource "aws_route_table_association" "private_subnet_association" {
   count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
 
}


resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-web-sg"
  description = "Security group for web servers"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  // Egress rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          // All protocols
    cidr_blocks = ["0.0.0.0/0"] // Allow traffic to all destinations
  }
}


resource "aws_lb" "alb" {
  name               = "dev-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.web_sg.id]
  
  #subnets         = [aws_subnet.public.id] # Assuming you want the ALB to be in the public subnet
  subnets            = [
    aws_subnet.public[0].id,
    aws_subnet.public[1].id,
    aws_subnet.public[2].id
  ]
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

variable "instance_count" {
  description = "Number of Apache server instances to launch"
  type        = number
  default     = 1
}

variable "apache_ami" {
  description = "AMI ID for the Apache server instance"
  type        = string
  default     = "ami-07caf09b362be10b8"
}

variable "instance_type" {
  description = "Instance type for the Apache server instance"
  type        = string
  default     = "t3.micro"
}



resource "aws_instance" "apache_server" {
  count         = var.instance_count
  ami           = var.apache_ami
  instance_type = var.instance_type
  #subnet_id       = aws_subnet.public.id
  subnet_id = aws_subnet.public[count.index].id

  security_groups = [aws_security_group.web_sg.id]




  user_data = <<-EOF
    #!/bin/bash
    # Install Apache web server
    sudo yum update -y
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "The page was created by the user data" | sudo tee /var/www/html/index.html
  EOF

  tags = {
  Name        = "${var.project_name}-apache-instance"
  Environment = "dev"
}

}













