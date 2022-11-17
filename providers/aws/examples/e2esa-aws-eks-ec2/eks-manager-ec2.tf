
# this is a statis VM to execute kubectl commands in nodes

resource "aws_instance" "eks-manager" {
  ami                         = var.ami
  instance_type               = var.instance_type
  associate_public_ip_address = var.associate_public_ip_address
  availability_zone           = var.availability_zone
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.vpc_security_group_ids
  user_data                   = templatefile("${path.module}/init.sh", {})
  key_name                    = var.key_name
  iam_instance_profile        = "${local.name}-${var.iam_instance_profile}"
  disable_api_termination     = var.disable_api_termination
  tags                        = merge({ "ResourceName" = "eks_manager" }, local.tags)
  depends_on                  = [aws_iam_role.role]
}