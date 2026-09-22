provider "aws" {
  region = "eu-central-1"
}

# --- Phase 2: VPC Netzwerk ---
module "vpc" {
  source       = "./modules/vpc"
  project_name = "company-portal"
  environment  = "dev"
}

# --- Phase 1 PoC: EC2 Test-Server ---
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "mein_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  # Integration in das neue VPC
  subnet_id                   = module.vpc.public_subnet_ids[0]
  vpc_security_group_ids      = [module.vpc.sg_loadbalancer_id]
  associate_public_ip_address = true

  tags = {
    Name = "MeinKostenloserServer"
  }
}
module "storage" {
  source       = "./modules/storage"
  project_name = "company-portal"
  environment  = "dev"
}

module "database" {
  source                 = "./modules/database"
  project_name           = "company-portal"
  environment            = "dev"

  # Verknüpfung mit Phase 2 (VPC)
  private_subnet_ids     = module.vpc.private_subnet_ids
  vpc_security_group_ids = [module.vpc.sg_database_id]

  db_username            = "postgresadmin"
  db_password            = "SuperSecretPassword123!"
}