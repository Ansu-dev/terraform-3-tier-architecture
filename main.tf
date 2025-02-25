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
}

# subnet 모듈 생성
module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id # vpc의 라우트 테이블 정보가 필요하므로 vpc 모듈에서 아웃풋으로 해당 정보를 가져옴
  route_table_id = module.vpc.route_table_id
}