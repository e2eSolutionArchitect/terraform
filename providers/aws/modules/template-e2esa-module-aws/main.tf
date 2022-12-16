
resource "name" "this" {

  tags = merge(
    { "resourcename" = var.cd_app_name }, var.tags
  )
}