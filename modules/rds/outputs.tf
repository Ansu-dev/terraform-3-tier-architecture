output "db_instance_endpoint" {         # 출력 변수 "db_instance_endpoint" 정의
  value = aws_db_instance.database.endpoint # 출력 값으로 DB 인스턴스의 엔드포인트 설정
}

output "db_instance_id" {         # 출력 변수 "db_instance_id" 정의
  value = aws_db_instance.database.id # 출력 값으로 DB 인스턴스의 ID 설정
}