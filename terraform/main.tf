resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet" {
  count = 2
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  vpc_id = aws_vpc.main.id
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
}

resource "aws_security_group" "ecs_sg" {
  name        = "medusa-sg"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ecs_cluster" "medusa" {
  name = "${var.project_name}-cluster"
}

resource "aws_ecs_task_definition" "medusa" {
  family                   = "medusa-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([{
    name      = "medusa"
    image     = aws_ecr_repository.medusa.repository_url
    portMappings = [{
      containerPort = 9000
      hostPort      = 9000
    }]
    environment = [
      { name = "NODE_ENV", value = "production" }
    ]
  }])
}

resource "aws_ecs_service" "medusa" {
  name            = "${var.project_name}-service"
  cluster         = aws_ecs_cluster.medusa.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.medusa.arn
  desired_count   = 1

  network_configuration {
    subnets         = aws_subnet.subnet[*].id
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}
