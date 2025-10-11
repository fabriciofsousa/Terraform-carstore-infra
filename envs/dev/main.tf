# main.tf

module "rds" {
  source      = "../../modules/rds"
  db_name     = "carstore"
  db_username = "postgres"
  db_password = "postgres"
}

module "dynamodb" {
  source = "../../modules/dynamodb"
}

module "cognito" {
  source = "../../modules/cognito"
  project = var.project
}


provider "aws" {
  region                      = var.region
  profile                     = "carstore"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

resource "aws_ecr_repository" "app" {
  name = "carstore"
}

resource "aws_vpc" "app" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = { Name = "carstore-vpc" }
}
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.app.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "carstore-public-a" }
}
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.app.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { Name = "carstore-public-b" }
}
module "ecs" {
  source       = "../../modules/ecs"
  cluster_name = var.cluster_name
  subnet_ids   = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  task_family  = "carstore-task"
  aws_region   = var.region
  service_name = "carstore-service"
  ecr_repository_url = aws_ecr_repository.app.repository_url
  image_tag = "clientes-latest"

  ecr_repository_url_vendas   = "797666780798.dkr.ecr.us-east-1.amazonaws.com/carstore:vendas-latest"
  image_tag_vendas            = "vendas-latest"

  ecr_repository_url_veiculos = "797666780798.dkr.ecr.us-east-1.amazonaws.com/carstore:veiculos-latest"
  image_tag_veiculos          = "veiculos-latest"
}

