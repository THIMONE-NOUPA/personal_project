

# Define a Security Group for the Load Balancer
resource "aws_security_group" "alb_security_group" {
  vpc_id = aws_vpc.spring_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_security_group"
  }
}

# Create an Application Load Balancer (ALB)
resource "aws_lb" "spring_alb" {
  name               = "spring-alb"
  internal           = false  # False means it's internet-facing
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_security_group.id]

  # Use two public subnets in different availability zones
  subnets            = [
    aws_subnet.spring_public_subnet.id,      # us-east-1a
    aws_subnet.spring_public_subnet_2.id     # us-east-1b
  ]

  enable_deletion_protection = false

  tags = {
    Name = "spring-alb"
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.spring_alb.arn
  port              = 443                         # Port HTTPS
  protocol          = "HTTPS"                     # Protocole HTTPS
  certificate_arn   = "arn:aws:acm:us-east-1:170631244365:certificate/a452746d-a401-41a1-806b-e1aa7a8c98e1"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_target_group.arn
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.spring_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# Rule for SonarQube
resource "aws_lb_listener_rule" "sonarqube_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 10  # Ensure priority is unique and lower than other rules

  condition {
    host_header {
      values = ["sonarqube-server.thimone.com"]
    }
  }

  action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.sonar_target_group.arn
  }
}

# Rule for Jenkins (optional, since it is the default action)
resource "aws_lb_listener_rule" "jenkins_rule" {
  listener_arn = aws_lb_listener.https_listener.arn
  priority     = 20  # Ensure priority is unique and higher than SonarQube

  condition {
    host_header {
      values = ["jenkins-server.thimone.com"]
    }
  }

  action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.jenkins_target_group.arn
  }
}


# Target Group for Jenkins Server
resource "aws_lb_target_group" "jenkins_target_group" {
  name        = "jenkins-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.spring_vpc.id
    health_check {
        port               = "8080"
        protocol           = "HTTP"
        path               = "/login"
        interval           = 30
        timeout            = 6
        healthy_threshold  = 2
        unhealthy_threshold = 3
    }
  target_type = "instance"
}

# Target Group for SonarQube Server
resource "aws_lb_target_group" "sonar_target_group" {
  name        = "sonar-target-group"
  port        = 9000
  protocol    = "HTTP"
  vpc_id      = aws_vpc.spring_vpc.id
    health_check {
        port               = "9000"
        protocol           = "HTTP"
        path               = "/api/system/health"
        interval           = 30
        timeout            = 6
        healthy_threshold  = 2
        unhealthy_threshold = 3
    }
  target_type = "instance"
}

# Attach Jenkins instance to Target Group
resource "aws_lb_target_group_attachment" "jenkins_attachment" {
  target_group_arn = aws_lb_target_group.jenkins_target_group.arn
  target_id        = var.instance_jenkins_id  # Instance ID from Jenkins module
  port             = 8080
   #depends_on = module.jenkins_server
}

# Attach SonarQube instance to Target Group
resource "aws_lb_target_group_attachment" "sonar_attachment" {
  target_group_arn = aws_lb_target_group.sonar_target_group.arn
  target_id        = var.instance_sonar_id  # Instance ID from Sonar module
  port             = 9000
  #depends_on = module.sonar_server
}
