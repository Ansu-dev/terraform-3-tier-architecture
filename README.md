### 3-Tier Architecture by Terraform

<img width="518" alt="Image" src="https://github.com/user-attachments/assets/0ff12900-97d8-4a62-a56a-ea44e2f1622f" />

### Terraform Module의 Flow는 아래와 같습니다.

1. 루트 main.tf 파일에서 모듈을 호출하고, 필요한 변수 값을 전달합니다.
2. 각 모듈의 variables.tf 파일에서 변수 값을 받아 사용합니다.
3. 모듈의 main.tf 파일에서 리소스를 생성합니다.
4. 모듈의 outputs.tf 파일에서 생성된 리소스의 출력값을 정의합니다.
5. 루트 main.tf 파일에서 모듈의 출력값을 다른 모듈에 전달하여 의존성을 관리합니다.