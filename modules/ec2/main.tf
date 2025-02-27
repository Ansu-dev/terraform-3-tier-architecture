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

resource "aws_instance" "nat_instance" {
  ami = "ami-0c2d3e23e757b5d84" # nat_instance전용 ami
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_ids[1]
  vpc_security_group_ids = [var.security_group_id]
  availability_zone = "ap-northeast-2c"
  key_name = var.key_name
  source_dest_check = false # nat_instance일 경우

  tags = {
    Name = "nat_instance"
  }
}

resource "aws_instance" "web1" {
  ami = "ami-024ea438ab0376a47"
  instance_type = "t2.micro"
  subnet_id = var.private_subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]
  availability_zone = "ap-northeast-2a"
  key_name = var.key_name

  tags = {
    Name = "web1"
  }
}

resource "aws_instance" "web2" {
  ami = "ami-024ea438ab0376a47"
  instance_type = "t2.micro"
  subnet_id = var.private_subnet_ids[1]
  vpc_security_group_ids = [var.security_group_id]
  availability_zone = "ap-northeast-2c"
  key_name = var.key_name

  tags = {
    Name = "web2"
  }
}