# alb resource 생성
resource "aws_lb" "alb" {
  name = "my-alb"
  internal = false # 외부
  load_balancer_type = "application"
  security_groups = var.security_group_ids
  subnets = var.subnet_ids
  enable_deletion_protection = false # 삭제보호 기능
}

# 대상그룹 생성
resource "aws_lb_target_group" "alb_target_group" {
  name = "my-target-group"
  port = 8080
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    path = "/"
    protocol = "HTTP"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }
  # stickiness { # 세션 관리
  #   type = "lb_cookie"
  #   cookie_duration = 86400 # 1day in seconds
  # }
}


resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = 8080
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

# web1를 target-group에 등록
resource "aws_lb_target_group_attachment" "web1" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.target_instance_ids[0]
  port = 8080
}

# web2를 target-group에 등록
resource "aws_lb_target_group_attachment" "web2" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.target_instance_ids[1]
  port = 8080
}