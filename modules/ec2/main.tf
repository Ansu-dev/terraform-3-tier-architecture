resource "aws_instance" "bastion_host" {
  ami = "ami-024ea438ab0376a47"
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]
  availability_zone = "ap-northeast-2a"
  key_name = var.key_name

  tags = {
    Name = "bastion_host"
  }
}