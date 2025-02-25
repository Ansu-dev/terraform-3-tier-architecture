output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "route_table_id" {
  value = aws_route_table.main_rt.id
}