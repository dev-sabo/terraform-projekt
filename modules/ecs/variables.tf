variable "project_name" {
  description = "Name des Projekts"
  type        = string
}

variable "environment" {
  description = "Umgebung (z. B. dev)"
  type        = string
  default     = "dev"
}

variable "private_subnet_ids" {
  description = "IDs der privaten Subnetze für die ECS Tasks"
  type        = list(string)
}

variable "ecs_security_group_ids" {
  description = "Security Group IDs für die ECS Tasks"
  type        = list(string)
}

variable "ecr_repository_url" {
  description = "URL des ECR-Repositories für das Backend-Image"
  type        = string
}