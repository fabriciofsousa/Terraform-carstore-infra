resource "aws_db_instance" "this" {
  identifier              = "${var.db_name}-rds"
  engine                  = "postgres"
  engine_version          = "15.5"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  publicly_accessible     = true
  port                    = 5432
  skip_final_snapshot     = true


}
