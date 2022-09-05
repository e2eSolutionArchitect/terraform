resource "aws_lb" "this" {
  name                       = "${var.project}-lb"
  subnets                    = var.lb_subnets
  internal                   = var.lb_internal
  security_groups            = [aws_security_group.lb_sg.id]
  load_balancer_type         = var.lb_load_balancer_type
  enable_deletion_protection = var.lb_enable_deletion_protection
  tags = merge(
    { "Name" = "${var.project}-lb" }, local.tags
  )
}

resource "aws_lb_target_group" "blue_tg" {
  name        = "blue_tg-${var.project}"
  port        = var.lb_target_port
  protocol    = var.lb_protocol    #"HTTP"
  target_type = var.lb_target_type #"ip" for ALB/NLB, "instance" for autoscaling group, 
  vpc_id      = var.vpc_id
  tags        = merge({ "Name" = "blue-tg-${var.project}" }, local.tags)
  depends_on  = [aws_lb.this]
}

resource "aws_lb_target_group" "green_tg" {
  name        = "green_tg-${var.project}"
  port        = var.lb_target_port
  protocol    = var.lb_protocol    #"HTTP"
  target_type = var.lb_target_type #"ip" for ALB/NLB, "instance" for autoscaling group, 
  vpc_id      = var.vpc_id
  tags        = merge({ "Name" = "green-tg-${var.project}" }, local.tags)
  depends_on  = [aws_lb.this]
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.lb_listener_port     #"80" or "443"
  protocol          = var.lb_listener_protocol #"HTTP" or "TLS"
  #certificate_arn   = "arn:aws:iam::#########:server-certificate/test_cert_owernuy76weriiuwer54"
  #alpn_policy       = "HTTP2Preferred"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.green.arn
  }

  depends_on = [
    aws_lb.this
  ]
}