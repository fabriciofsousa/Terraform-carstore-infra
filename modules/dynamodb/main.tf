# modules/dynamodb/main.tf

resource "aws_dynamodb_table" "vendas" {
  name           = "carstore-vendas"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "venda_id"
  attribute {
    name = "venda_id"
    type = "S"
  }
}



output "vendas_table_name" {
  value = aws_dynamodb_table.vendas.name
}
