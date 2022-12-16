output "arn" {
  description = "The Amazon Resource Name (ARN) of the key."
  value       = try(aws_kms_key.kms.arn, "")
}

output "key_id" {
  description = "The globally unique identifier for the key."
  value       = try(aws_kms_key.kms.key_id, "")
}

output "tags_all" {
  description = " A map of tags assigned to the resource, including those inherited from the provider default_tags"
  value       = try(aws_kms_key.kms.tags_all, "")
}