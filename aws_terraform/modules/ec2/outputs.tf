locals {
  web_security_group_id = aws_security_group.web_sg.id

  instance_ids = [aws_instance.web01.id, aws_instance.web02.id]
}

output "web_sg_id" {
  value       = local.web_security_group_id
  description = "Output id of the created web-security-group."
}

output "instance_ids" {
  value       = local.instance_ids
  description = "Output ids of the created some instances."
}