variable "db_name" {
  default = "carstore"
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  description = "Senha do banco"
  type        = string
  sensitive   = true
  default     = "postgres"
}
