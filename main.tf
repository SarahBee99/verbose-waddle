locals {
  resource_name = "${var.name_prefix}-server"
}

resource "aws_instance" "server" {
  count         = var.instance_count
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = var.instance_type

  user_data = file("${path.module}/userdata.sh")

  vpc_security_group_ids = [aws_security_group.server_sg.id]

  tags = {
    Name      = "${local.resource_name}-${count.index + 1}"
    ManagedBy = "Terraform"
  }
}


resource "aws_security_group" "server_sg" {
  name        = "${var.name_prefix}-sg"
  description = "Ingress rules for SSH and containers"

  tags = {
    Name      = "${local.resource_name}-sg"
    ManagedBy = "Terraform"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_outboundtraffic" {
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 0
  ip_protocol       = "-1"
  to_port           = 0

  tags = {
    Name      = "For all outboundtraffic"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

  tags = {
    Name      = "For SSH"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_dozzle" {
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8080
  ip_protocol       = "tcp"
  to_port           = 8080

  tags = {
    Name      = "For Dozzle"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_filebrowser" {
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 8090
  ip_protocol       = "tcp"
  to_port           = 8090

  tags = {
    Name      = "For Filebrowser"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_flame" {
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5005
  ip_protocol       = "tcp"
  to_port           = 5005

  tags = {
    Name      = "For Flame"
  }
}