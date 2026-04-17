provider "aws" {
  region  = "eu-west-1"
  profile = "default"
}

data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.11.20260406.2-kernel-6.18-x86_64"]
  }
}

output "latest_amazon_linux_ami_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

resource "aws_instance" "server" {
  # ami         = "ami-040e10ddbaf780d2f" 
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"

   vpc_security_group_ids = [aws_security_group.server_sg.id]

  tags = {
    Name = "sarah-terraform-server"
    ManagedBy = "Terraform"
  }
}
resource "aws_security_group" "server_sg" {
  name = "sarah-sg"
  description = "Ingress rule for SSH" 
}
resource "aws_vpc_security_group_ingress_rule" "allow_ssh" { 
  security_group_id = aws_security_group.server_sg.id
  cidr_ipv4 = "0.0.0.0/0" 
  from_port = 22 
  ip_protocol = "tcp" 
  to_port = 22 
}
