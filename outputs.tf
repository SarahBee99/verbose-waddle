output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu_ami.id
}

output "server_public_dns" {
  value = aws_instance.server[*].public_dns
}