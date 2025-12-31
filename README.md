# 인프라

### VPC Network 구조

<img width="791" height="1041" alt="Image" src="https://github.com/user-attachments/assets/95ccbcba-4d86-45bb-8c9a-0386bb181a73" />

### ECS Dev 환경 구조

<img width="791" height="956" alt="Image" src="https://github.com/user-attachments/assets/9f4f02a9-a34d-4566-8742-064b9d9afe81" />

<br>

[변경]

- EC2 방식에서 ECS Fargate 방식으로 변경
- ECS Service가 자동으로 Target Group 등록, attachment 삭제

[이슈]

- 빌드 파이프라인 추가 예정 (SQS -> Lambda -> ECS RunTask)
  - EventBridge Pipes vs Lambda
- 컨테이너 로그 저장용 CloudWatch Logs 추가 (기존 아키텍처에는 없었음)
  - 로그 보관 고려해야 함
