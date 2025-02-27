resource "aws_db_instance" "database" {
  identifier        = var.db_name
  engine            = "postgres"
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  username          = var.username
  password          = var.password
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name = aws_db_subnet_group.database_subnet.name
}

resource "aws_db_subnet_group" "database_subnet" {
  name = "${var.db_name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.db_name}-subnet-group"
  }
}