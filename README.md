# 인프라

### VPC Network 구조

<img width="400" height="600" alt="Image" src="https://github.com/user-attachments/assets/95ccbcba-4d86-45bb-8c9a-0386bb181a73" />

### ECS Dev 환경 구조

<img width="400" height="600" alt="Image" src="https://github.com/user-attachments/assets/9f4f02a9-a34d-4566-8742-064b9d9afe81" />

### 배포 파이프라인 및 서비스 구조

<img width="400" height="600" alt="Image" src="https://github.com/user-attachments/assets/9420744c-ffac-4d88-8bec-fd9dbadbec4a" />

<br>

[변경]

- EC2 방식에서 ECS Fargate 방식으로 변경
- ECS Service가 자동으로 Target Group 등록, attachment 삭제
- Worker Task Fargate -> FargateSpot 변경
- 빌드 파이프라인 추가 (SQS -> EventBridge Pipes -> ECS RunTask)

[이슈]

- Task 실행 중 Spot 인터럽션 시 재처리 로직 필요 (Worker)
