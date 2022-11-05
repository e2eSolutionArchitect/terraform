
resource "name" "this" {

  tags = merge(
    { "ResourceName" = var.cd_app_name }, var.tags
  )
}