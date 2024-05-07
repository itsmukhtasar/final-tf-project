# Import the networking module
module "networking" {
  source = "../networking" 

  # Pass required variables from autoscaling module to networking module
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}

# Launch Configuration
resource "aws_launch_configuration" "example" {
  name_prefix   = "final-lc-"
  image_id      = "ami-07caf09b362be10b8"
  instance_type = "t2.micro"
  security_groups = [module.networking.autoscaling_security_group_id] 
}

# Autoscaling Group
resource "aws_autoscaling_group" "example" {
  name                = "${var.project_name}-autoscaling-group"
  vpc_zone_identifier = module.networking.public_subnet_ids 

  # Specify the launch configuration to use for launching instances
  launch_configuration = aws_launch_configuration.example.name 

  # Other autoscaling group configurations like instance type, desired_capacity, etc.
  min_size = 1 # Minimum number of instances
  max_size = 5 # Maximum number of instances

 
}














