# -----------------------------------------------------------------------------
# Security Groups (3-Tiers Architecture)
# -----------------------------------------------------------------------------

resource "aws_security_group" "alb_sg" {
  name        = "tf-ent-plat-${var.environment}-alb-sg"
  description = "Security group for the Application Load Balancer"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "tf-ent-plat-${var.environment}-alb-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "app_sg" {
  name        = "tf-ent-plat-${var.environment}-app-sg"
  description = "Security group for the Application Servers"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description     = "Allow inbound traffic from ALB only"
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "tf-ent-plat-${var.environment}-app-sg"
    Environment = var.environment
  }
}

resource "aws_security_group" "db_sg" {
  name        = "tf-ent-plat-${var.environment}-db-sg"
  description = "Security group for the Database Servers"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_id

  ingress {
    description     = "Allow inbound traffic from Application Servers only"
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "tf-ent-plat-${var.environment}-db-sg"
    Environment = var.environment
  }
}

# -----------------------------------------------------------------------------
# IAM Role (Application Execution Role)
# -----------------------------------------------------------------------------

resource "aws_iam_role" "app_execution_role" {
  name = "tf-ent-plat-${var.environment}-app-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "app_execution_role_logs" {
  role       = aws_iam_role.app_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
