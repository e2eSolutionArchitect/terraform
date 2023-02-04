output "aws_codepipeline_arn" {
  value       = module.codepipeline.aws_codepipeline_arn
  description = "aws codepipeline project arn"
}

output "aws_codebuild_project_arn" {
  value       = module.codebuild.aws_codebuild_project_arn
  description = "aws codebuild project arn"
}