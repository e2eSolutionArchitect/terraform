resource "aws_launch_template" "this" {
  name          = "${var.project}-tpl"
  image_id      = var.image_id
  instance_type = var.instance_type #"t2.micro"
  #instance_type = "${terraform.env == "prod" ? "t2.medium" : var.instance_type}"
  key_name  = var.key_name != null ? var.key_name : null
  user_data = filebase64("${path.module}/ec2-init.sh")


  # iam_instance_profile {
  #   name = "test"
  # }

  #vpc_security_group_ids = var.vpc_security_group_ids
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.vpc_security_group_ids
  }

  tag_specifications {
    resource_type = "instance"
    tags          = merge({ "ResourceName" = "${var.project}-tpl" }, local.tags)
  }

  # depends_on = [
  #   aws_security_group.lb_sg
  # ]
}

resource "aws_autoscaling_group" "this" {

  name                      = "${var.project}-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  health_check_grace_period = 300
  health_check_type         = var.asg_health_check_type #"ELB"
  #availability_zones = var.availability_zones #["us-east-1a"]
  vpc_zone_identifier = var.lb_subnets
  target_group_arns   = [module.aws_lb.lb_tg_arn] #var.target_group_arns
  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version #"$Latest"
  }
  depends_on = [module.aws_lb]
}