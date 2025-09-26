resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags = {
    Name = "${var.project}-vpc"
  }
}

resource "aws_subnet" "public" {
  count                   = 2
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.cidr_block, 4, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "${var.project}-public-${count.index}"
  }
}

data "aws_availability_zones" "available" {}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}
