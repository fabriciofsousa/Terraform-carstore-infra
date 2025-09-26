variable "cluster_name" {
  type        = string
  description = "Nome do cluster EKS"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Lista de subnets onde o EKS será criado"
}

variable "vpc_id" {
  type        = string
  description = "VPC onde o cluster será criado"
  default     = null
}