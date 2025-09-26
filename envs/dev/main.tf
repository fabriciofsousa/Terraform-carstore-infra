# main.tf
module "vpc" {
  source  = "../../modules/vpc"
  project = var.project
}

module "eks" {
  source       = "../../modules/eks"
  cluster_name = var.cluster_name
  subnet_ids   = module.vpc.public_subnets
}

module "rds" {
  source  = "../../modules/rds"
  db_name = "carstore"
}

module "dynamodb" {
  source = "../../modules/dynamodb"
}

module "cognito" {
  source = "../../modules/cognito"
  project = var.project
}

module "ecr" {
  source  = "../../modules/ecr"
  project = var.project
}



provider "aws" {
  region                      = var.region
  profile                     = "carstore"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}
