output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_instance.app_server[*].id
}

output "security_group_id" {
  description = "ID of the created security group"
  value       = aws_security_group.app_sg.id
}
