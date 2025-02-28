resource "aws_autoscaling_group" "web1_asg" {
  name = "web1-asg"
  desired_capacity = 1 # 최초 생성될 인스턴스
  max_size = 3
  min_size = 1
  launch_template {
    id = var.web1_launch_template_id
    version = "$Latest"
  }
  vpc_zone_identifier = var.private_subnet_ids
  target_group_arns = [var.aws_lb_target_group]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "web-asg"
  }
}