output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

#Fixed so it's working but disabled since by default I am not using a public ip
output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}
