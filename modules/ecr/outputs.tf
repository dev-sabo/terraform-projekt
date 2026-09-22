output "repository_url" {
  description = "Die URL des ECR-Repositories für den Docker-Push"
  value       = aws_ecr_repository.backend.repository_url
}