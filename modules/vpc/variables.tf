variable "project_name" {
  description = "Name des Projekts (z. B. company-portal)"
  type        = string
}

variable "environment" {
  description = "Umgebung (z. B. dev, prod)"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR-Block für das VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  description = "CIDR-Blöcke für die öffentlichen Subnetze"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  description = "CIDR-Blöcke für die privaten Subnetze"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "availability_zones" {
  description = "Liste der zu nutzenden Availability Zones"
  type        = list(string)
  default     = ["eu-central-1a", "eu-central-1b"]
}