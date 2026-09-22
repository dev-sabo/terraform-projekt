output "vpc_id" {
  description = "Die ID des VPCs"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs der oeffentlichen Subnetze"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs der privaten Subnetze"
  value       = aws_subnet.private[*].id
}

output "sg_loadbalancer_id" {
  description = "Security Group ID fuer den ALB"
  value       = aws_security_group.loadbalancer.id
}

output "sg_backend_id" {
  description = "Security Group ID fuer die Backend Container"
  value       = aws_security_group.backend.id
}

output "sg_database_id" {
  description = "Security Group ID fuer die RDS Datenbank"
  value       = aws_security_group.database.id
}