provider "aws" {
  region = "eu-central-1"
}

# --- Phase 2: VPC Netzwerk ---
module "vpc" {
  source       = "./modules/vpc"
  project_name = "company-portal"
  environment  = "dev"
}

# --- Phase 3: S3 Storage (AES-verschlüsselt) ---
module "storage" {
  source       = "./modules/storage"
  project_name = "company-portal"
  environment  = "dev"
}

# --- Phase 3: RDS PostgreSQL (AES-verschlüsselt im privaten Subnetz) ---
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

# --- Phase 4: ECR (Elastic Container Registry) ---
module "ecr" {
  source       = "./modules/ecr"
  project_name = "company-portal"
  environment  = "dev"
}

# --- Phase 4: ECS (Elastic Container Service & Fargate Cluster) ---
module "ecs" {
  source                 = "./modules/ecs"
  project_name           = "company-portal"
  environment            = "dev"

  # Verknüpfung mit VPC und ECR
  private_subnet_ids     = module.vpc.private_subnet_ids
  ecs_security_group_ids = [module.vpc.sg_backend_id]
  ecr_repository_url     = module.ecr.repository_url
}