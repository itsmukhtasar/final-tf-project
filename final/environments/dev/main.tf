module "networking" {
  source = "../../modules/networking"
#   public_subnets_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   private_subnets_cidr_blocks = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
 }

module "autoscaling" {
  source = "../../modules/autoscaling"
  ami_id = "ami-07caf09b362be10b8"
  
}




















