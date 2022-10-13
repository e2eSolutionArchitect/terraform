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

  # vpc_security_group_ids = var.vpc_security_group_ids

  # Note: If using 'network_interfaces' like below then DON't user 'vpc_security_group_ids' separately. use 'security_groups' under network_interfaces
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