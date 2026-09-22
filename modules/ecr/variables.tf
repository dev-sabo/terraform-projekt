variable "project_name" {
  description = "Name des Projekts"
  type        = string
}

variable "environment" {
  description = "Umgebung (z. B. dev)"
  type        = string
  default     = "dev"
}