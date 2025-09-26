output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "cognito_pool_id" {
  value = module.cognito.user_pool_id
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "dynamodb_table_name" {
  value = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  value = module.dynamodb.table_arn
}

output "ecr_url" {
  value = module.ecr.repository_url
}
