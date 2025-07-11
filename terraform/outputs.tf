## Defines output values (e.g., public IP, instance ID)
output "ecr_repository_url" {
  value = aws_ecr_repository.medusa.repository_url
}
