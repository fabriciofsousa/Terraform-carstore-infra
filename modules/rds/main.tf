resource "aws_db_instance" "this" {
  identifier        = "${var.db_name}-rds"
  engine            = "postgres"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name              = var.db_name
  username          = "postgres"
  password          = "postgres"
  skip_final_snapshot = true
}

variable "db_name" {}
output "db_endpoint" {
  value = aws_db_instance.this.address
}
