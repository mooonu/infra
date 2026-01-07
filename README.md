# 인프라

### VPC Network 구조

<img width="400" height="600" alt="Image" src="https://github.com/user-attachments/assets/95ccbcba-4d86-45bb-8c9a-0386bb181a73" />

### ECS Dev 환경 구조

<img width="400" height="600" alt="Image" src="https://github.com/user-attachments/assets/9f4f02a9-a34d-4566-8742-064b9d9afe81" />

### 배포 파이프라인 및 서비스 구조

<img width="400" height="600" alt="Image" src="https://github.com/user-attachments/assets/049e8940-e7c6-4275-9db6-3c1abed9b861" />

<br>

[변경]

- EC2 방식에서 ECS Fargate 방식으로 변경
- ECS Service가 자동으로 Target Group 등록, attachment 삭제
- Worker Task Fargate -> FargateSpot 변경
- 배포 파이프라인 추가 (SQS -> EventBridge Pipes -> ECS RunTask)
- CloudFront Functions 경로 매핑 -> CloudFront Functions + KeyValueStore 경로 매핑

[이슈]

- Task 실행 중 Spot 인터럽션 시 재처리 로직 필요 (Worker)
- CloudWatch 더 똑똑하게 쓰는 방법 알아내기 (콘솔에서 열심히 클릭해서 보는 중)
- 관리되지 않는 리소스
  - S3
  - Route53
  - ACM
  - CloudFront Distributions
  - CloudFront Functions
  - CloudFront KeyValueStore
  - SQS
  - ECR
