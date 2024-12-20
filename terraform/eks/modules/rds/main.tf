resource "aws_db_subnet_group" "this" {
  name = "db_subnet_group"
  subnet_ids = [
    var.subnet_private1_id,
    var.subnet_private2_id
  ]

  tags = {
    Name = "${var.env}-db-subnet-group"
  }
}

resource "aws_security_group" "this" {
  name        = "db_security_group"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.env}-db-security-group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 5432
  ip_protocol = "tcp"
  to_port     = 5432
}

resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id

  cidr_ipv4   = var.vpc_cidr
  from_port   = 5432
  ip_protocol = "tcp"
  to_port     = 5432
}

resource "aws_db_instance" "this" {
  identifier_prefix      = var.identifier_prefix
  allocated_storage      = var.allocated_storage
  db_name                = var.db_name
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.db_user
  password               = var.db_password
  skip_final_snapshot    = true

  tags = {
    Name = "${var.env}-db"
  }
}