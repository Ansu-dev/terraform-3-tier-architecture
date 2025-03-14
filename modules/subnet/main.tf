# public subnet 1 생성
resource "aws_subnet" "public-1" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "public-subnet-1" # 서브넷의 태그 설정
  }
}

# public subnet 2 생성
resource "aws_subnet" "public-2" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "public-subnet-2" # 서브넷의 태그 설정
  }
}

# private subnet 1 생성
resource "aws_subnet" "private-1" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "private-subnet-1"
  }
}

# private subnet 2 생성
resource "aws_subnet" "private-2" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name = "private-subnet-2"
  }
}

#### public subnet과 라우트 테이블 연결

# public subnet1과 라우트 테이블에 연결
resource "aws_route_table_association" "public-1" {
  subnet_id = aws_subnet.public-1.id
  route_table_id = var.route_table_id
}
# public subnet2과 라우트 테이블에 연결
resource "aws_route_table_association" "public-2" {
  subnet_id = aws_subnet.public-2.id
  route_table_id = var.route_table_id
}

# private subnet1과 라우트 테이블에 연결
resource "aws_route_table_association" "private-1" {
  subnet_id = aws_subnet.private-1.id
  route_table_id = var.route_table_id_1
}

# private subnet2과 라우트 테이블에 연결
resource "aws_route_table_association" "private-2" {
  subnet_id = aws_subnet.private-2.id
  route_table_id = var.route_table_id_1
}