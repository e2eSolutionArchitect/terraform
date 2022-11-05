resource "aws_eks_fargate_profile" "this" {
  cluster_name           = aws_eks_cluster.this.name
  fargate_profile_name   = "${local.name}-fargate-profile"
  pod_execution_role_arn = aws_iam_role.role_fargate.arn
  subnet_ids             = var.public_subnets

  selector {
    namespace = var.namespace
  }
}