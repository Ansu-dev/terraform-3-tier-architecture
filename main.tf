terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.54.1"
    }
  }
}
# root module

# aws provider 생성
provider "aws" {
  region = "ap-northeast-2" # 리전 설정
}

# vpc 모듈 생성
module "vpc" {
  source = "./modules/vpc" # VPC 모듈 소스 경로
  nat_instance_network_interface_id = module.ec2.nat_instance_network_interface_id # EC2 모듈에서 NAT인터페이스 ID 가져오기
}

# subnet 모듈 생성
module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id # vpc의 라우트 테이블 정보가 필요하므로 vpc 모듈에서 아웃풋으로 해당 정보를 가져옴
  route_table_id = module.vpc.route_table_id
  route_table_id_1 = module.vpc.route_table_id_1
}

module "security_group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "key_pair" {
  source = "./modules/key-pair"
}


module "ec2" {
  source = "./modules/ec2"
  security_group_id = module.security_group.security_group_id
  public_subnet_ids = module.subnet.public_subnet_ids
  private_subnet_ids = module.subnet.private_subnet_ids
  key_name = module.key_pair.key_name
}


module "s3" {
  source = "./modules/s3"
  bucket_name = "my-unique-bucket-name-gs" # unique한 이름
  acl = "private"
}

module "rds" {
  source = "./modules/rds"
  db_name = "mydatabase"
  username = "postgres"
  password = "test1234"
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_ids = module.subnet.private_subnet_ids
}


module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.subnet.public_subnet_ids
  security_group_ids = [module.security_group.security_group_id]
  target_instance_ids = [
    module.ec2.web1.id,
    module.ec2.web2.id
  ]
}

module "auto_scaling" {
  source = "./modules/auto-scaling"
  private_subnet_ids = module.subnet.private_subnet_ids
  web1_launch_template_id = module.launch_template.web1_launch_template_id
  aws_lb_target_group = module.alb.aws_lb_target_group
}

module "launch_template" {
  source = "./modules/launch-template"
  key_name = module.key_pair.key_name
  instance_type = "t2.micro"
  source_instance_id = module.ec2.web1.id
}