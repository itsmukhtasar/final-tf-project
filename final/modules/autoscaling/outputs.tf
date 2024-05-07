# Output: Autoscaling Group Name
output "autoscaling_group_name" {
  description = "The name of the autoscaling group."
  value       = aws_autoscaling_group.example.name
}

# Output: Autoscaling Group ID
output "autoscaling_group_id" {
  description = "The ID of the autoscaling group."
  value       = aws_autoscaling_group.example.id
}

# Output: Launch Configuration ID
output "launch_configuration_id" {
  description = "The ID of the launch configuration used by the autoscaling group."
  value       = aws_launch_configuration.example.id
}

# Output: Launch Configuration Name
output "launch_configuration_name" {
  description = "The name of the launch configuration used by the autoscaling group."
  value       = aws_launch_configuration.example.name
}

# Output: Autoscaling Security Group ID
output "autoscaling_security_group_id" {
  description = "The ID of the security group associated with the autoscaling group."
  value       = module.networking.autoscaling_security_group_id
}
