variable "cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
}



variable "vpc_id" {
  type        = string
  description = "VPC onde o cluster será criado"
  default     = null
}

variable "key_pair_name" {
  type        = string
  description = "Nome do keypair caso queira SSH nos nodes"
  default     = null
}
variable "task_family"      { default = "carstore-task" }

variable "ecr_repo_name"    { default = "carstore" } # nome do repositório no ECR
variable "image_tag" {
  description = "Tag da imagem"
  type        = string
  default = "latest"
}

variable "ecr_repository_url" {
  description = "URL do repositório ECR"
  type        = string
}

variable "ecr_repository_url_vendas" {
  description = "URL do repositório ECR da aplicação vendas"
  type        = string
}

variable "image_tag_vendas" {
  description = "Tag da imagem Docker da aplicação vendas"
  type        = string
}

variable "ecr_repository_url_veiculos" {
  description = "URL do repositório ECR da aplicação veiculos"
  type        = string
}

variable "image_tag_veiculos" {
  description = "Tag da imagem Docker da aplicação veiculos"
  type        = string
}


variable "subnet_ids" {
  description = "Lista de subnets para o ECS service"
  type        = list(string)
}

variable "aws_region" {
  description = "Região AWS para logs"
  type        = string
}

variable "service_name" {
  description = "Nome do ECS Service"
  type        = string
}