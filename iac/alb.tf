data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_lb" "challenge" {
  name               = "challenge-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.challenge.id]
  subnets            = data.aws_subnets.default.ids
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.challenge.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Forbidden"
      status_code  = "403"
    }
  }
}

resource "aws_security_group" "challenge" {
  name = "challenge"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_listener_rule" "challenge" {
  listener_arn = aws_lb_listener.front_end.arn

  action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Invalid request method"
      status_code  = "403"
    }
  }

  condition {
    http_request_method {
      values = ["POST"]
    }
  }
}
