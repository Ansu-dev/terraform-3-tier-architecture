output "nat_instance_network_interface_id" {
  value = aws_instance.nat_instance.primary_network_interface_id
}

output "web1" {
  value = aws_instance.web1
}

output "web2" {
  value = aws_instance.web2
}