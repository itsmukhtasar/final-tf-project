output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer (ALB)"
  value = module.networking.alb_dns_name
}

