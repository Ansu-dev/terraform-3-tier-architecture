# public subnet 1 생성
resource "aws_subnet" "public-1" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "public-subnet-1"
  }
}