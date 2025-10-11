output "ecs_cluster_arn" {
  value = module.ecs.cluster_arn
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

output "db_endpoint" {
  value = module.rds.db_endpoint
}

output "spring_datasource_url" {
  value = "jdbc:postgresql://${module.rds.db_endpoint}:5432/${module.rds.db_name}"
}

output "spring_datasource_username" {
  value = module.rds.db_username
}

output "spring_datasource_password" {
  value     = module.rds.db_password
  sensitive = true
}
