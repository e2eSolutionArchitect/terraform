# output "datapipeline_name" {
#   value       = try(module.aws_datapipeline.name, "")
#   description = "datapipeline name"
# }


output "aws_datapipeline_pipeline" {
  value       = try(aws_datapipeline_pipeline.name, "")
  description = "aws_datapipeline_pipeline name"
}

output "aws_datapipeline_pipeline_definition" {
  value       = try(aws_datapipeline_pipeline_definition.id, "")
  description = "aws_datapipeline_pipeline_definition id"
}
