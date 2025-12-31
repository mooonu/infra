data "aws_iam_policy_document" "ecs_task_execution_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# -- ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution" {
  name               = "qwik-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role.json

  tags = {
    Name = "qwik-ecs-task-execution-role"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "ecs_task_execution_ssm" {
  name = "qwik-ecs-ssm-policy"
  role = aws_iam_role.ecs_task_execution.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ssm:GetParameter",
          "ssm:GetParameters",
        ]
        Resource = "arn:aws:ssm:ap-northeast-2:*:parameter/qwik/*"
      }
    ]
  })
}

# -- ECS Task Role
resource "aws_iam_role" "ecs_task" {
  name               = "qwik-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_assume_role.json

  tags = {
    Name = "qwik-ecs-task-role"
  }
}