output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.vpc.id
}


output "public_subnet_ids" {
  description = "ID of the created public subnet"
  value       = aws_subnet.public.*.id
}

output "private_subnet_ids" {
  description = "ID of the created private subnet"
  value       = aws_subnet.private.*.id
}

output "autoscaling_security_group_id" {
  description = "ID of the security group for auto-scaling"
  value       = aws_security_group.web_sg.id
}


output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer (ALB)"
  value       = aws_lb.alb.dns_name
}



