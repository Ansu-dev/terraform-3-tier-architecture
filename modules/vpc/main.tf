resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16" # ip대역대(ip와 서브넷마스크를 조합하여 블록 생성)

  tags = {
    Name = "my-vpc"
  } # VPC 태그 설정
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id # VPC ID를 인터넷 게이트웨이에 연결

  tags = {
    Name = "my-igw" # 인터넷 게이트웨이의 태그 설정
  }
}

resource "aws_route_table" "main_rt" {
  vpc_id = aws_vpc.main_vpc.id # VPC ID를 인터넷 게이트웨이에 연결

  # 라우트 정보
  route {
    cidr_block = "0.0.0.0/0" # 모든 트래픽을 허용하는 CIDR 블록
    gateway_id = aws_internet_gateway.main_igw.id # 인터넷 게이트웨이를 라우트의 게이트웨이로 설정
  }

  tags = {
    Name = "my-route-table"
  }
}


resource "aws_route_table" "main1_rc" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "my-route-table-nat"
  }
}

resource "aws_route" "nat" {
  route_table_id = aws_route_table.main1_rc.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id = var.nat_instance_network_interface_id
}