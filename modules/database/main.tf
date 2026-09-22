# Gruppiert deine privaten Subnetze aus dem VPC für die Datenbank
resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}-${var.environment}-db-subnet-group"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "postgres" {
  identifier             = "${var.project_name}-${var.environment}-db"
  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20

  # Aktiviert die Verschlüsselung (Standard AWS KMS nutzt AES-256)
  storage_encrypted      = true

  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = var.vpc_security_group_ids

  username               = var.db_username
  password               = var.db_password

  skip_final_snapshot    = true # Für Entwicklungszwecke: Erlaubt schnelles "terraform destroy"
}