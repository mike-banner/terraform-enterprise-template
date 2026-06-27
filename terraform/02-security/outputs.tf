output "alb_sg_id" {
  description = "The ID of the Security Group for the ALB"
  value       = aws_security_group.alb_sg.id
}

output "app_sg_id" {
  description = "The ID of the Security Group for the Application"
  value       = aws_security_group.app_sg.id
}

output "db_sg_id" {
  description = "The ID of the Security Group for the Database"
  value       = aws_security_group.db_sg.id
}

output "app_iam_role_arn" {
  description = "The ARN of the IAM Execution Role for the Application"
  value       = aws_iam_role.app_execution_role.arn
}
