resource "aws_ami_from_instance" "web1_ami" {
  name               = "web-ami"
  source_instance_id = var.source_instance_id
  lifecycle {
    create_before_destroy = true # 기존 리소스를 삭제하기 전에 새로운 리소스를 먼저 생성
  }
}

resource "aws_launch_template" "web1_launch_template" {
  name = "web1-launch-template"
  image_id = aws_ami_from_instance.web1_ami.id
  instance_type = var.instance_type
  key_name = var.key_name

  lifecycle {
    create_before_destroy = true
  }
}