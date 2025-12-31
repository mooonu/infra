locals {
  ssm_prefix = "arn:aws:ssm:${var.aws_region}:${var.aws_account_id}:parameter/qwik/dev"

  secret_names = [
    "DATABASE_URL",
    "SECRET_KEY",
    "GITHUB_CLIENT_ID",
    "GITHUB_CLIENT_SECRET",
    "GITHUB_REDIRECT_URI"
  ]
}

# -- ECS Cluster
resource "aws_ecs_cluster" "this" {
  name = "qwik-cluster"

  tags = {
    Name = "qwik-cluster"
  }
}

# -- CloudWatch Log Group for API
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/qwik-api"
  retention_in_days = 7

  tags = {
    Name = "qwik-api-logs"
  }
}

# -- ECS Task Definition for API
resource "aws_ecs_task_definition" "api" {
  family                   = "qwik-api"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task.arn

  container_definitions = jsonencode([
    {
      name  = "qwik-api"
      image = "${var.ecr_repository_url}"

      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
          protocol      = "tcp"
        }
      ]

      secrets = [
        for name in local.secret_names : {
          name      = name
          valueFrom = "${local.ssm_prefix}/${name}"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/qwik-api"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }

      essential = true
    }
  ])
  tags = {
    Name = "qwik-api-task-definition"
  }
}

# -- ECS Service for API
resource "aws_ecs_service" "api" {
  name            = "qwik-api-service"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [
      for idx in var.ecs_subnets : module.network.private_subnet_ids[idx]
    ]
    security_groups  = [aws_security_group.ecs-container.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.this.arn
    container_name   = "qwik-api"
    container_port   = 8000
  }

  depends_on = [aws_lb_listener.https]

  tags = {
    Name = "qwik-api-service"
  }
}