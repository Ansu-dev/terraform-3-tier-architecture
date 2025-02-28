output "alb_dns_name" {
  value = aws_lb.alb.name
}

output "aws_lb_target_group" {
  value = aws_lb_target_group.alb_target_group.arn
}