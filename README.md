### 3-Tier Architecture by Terraform

<img width="518" alt="Image" src="https://github.com/user-attachments/assets/0ff12900-97d8-4a62-a56a-ea44e2f1622f" />

### Terraform Module의 Flow는 아래와 같습니다.

1. 루트 main.tf 파일에서 모듈을 호출하고, 필요한 변수 값을 전달합니다.
2. 각 모듈의 variables.tf 파일에서 변수 값을 받아 사용합니다.
3. 모듈의 main.tf 파일에서 리소스를 생성합니다.
4. 모듈의 outputs.tf 파일에서 생성된 리소스의 출력값을 정의합니다.
5. 루트 main.tf 파일에서 모듈의 출력값을 다른 모듈에 전달하여 의존성을 관리합니다.


### Private Subnet 연결
- Private Subnet은 외부와 통신하기 위해 **NAT Gateway**를 사용해야 합니다.
- 하지만, **NAT Gateway**는 비용이 비싸므로, 비용 절감을 위해 **NAT Instance**를 생성하여 아웃바운드 트래픽 역할만 수행하도록 구성할 수 있습니다.

### 베스천 호스트 (Bastion Host)
- 베스천 호스트는 내부 네트워크에 접근할 때 프록시 역할을 수행하는 인스턴스입니다.
- Application이 존재하는 EC2 Instance는 Private subnet에 존재하므로 Public 접근이 불가능

### ALB (Application Load Balancer)와 대상 그룹
- ALB의 대상 그룹으로 EC2 인스턴스 **web1**과 **web2**를 묶어 트래픽을 분산합니다.



